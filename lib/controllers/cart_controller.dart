import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

import '../constants/app_constatns.dart';
import '../constants/controllers.dart';
import '../model/cart_item.dart';
import '../model/product.dart';
import '../model/user.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;
  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, ChangeCartTotalPrice);
  }

  void addProductTocart(ProductModel product, String notice) {
    try {
      if (userController.userModel.value.cart.isNotEmpty &&
          !_fromnotsameCaffeteria(product)) {
        Get.snackbar(
          "You cant add from other caffeteria",
          "the caffeteria is not the same ",
        );
      } else if (_isItemAlreadyAdded(product)) {
        Get.snackbar(
            "Check your cat", "${product.ProductName} is already Added");
      } else {
        String itemid = Uuid().toString();
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemid,
              "productId": product.ProductID,
              "name": product.ProductName,
              "quantity": 1,
              "price": product.ProductPrice,
              "image": product.ProductPhoto,
              "cost": product.ProductPrice,
              "cafetriaId": product.caffeteriaid,
              "notice": notice
            }
          ])
        });
        Get.snackbar(
            "Itemadded", "${product.ProductName} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Erorr", "Cannot added to cart");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Eroor", "Cannot remove this item");
      debugPrint(e.message);
    }
  }

  ChangeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart.isNotEmpty) {
      userModel.cart.forEach((cartItem) {
        totalCartPrice += cartItem.cost;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      userController.userModel.value.cart
          .where((item) => item.productId == product.ProductID)
          .isNotEmpty;

  void decreaseQuantity(CartItemModel item) {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      item.quantity--;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(CartItemModel item) {
    removeCartItem(item);
    item.quantity++;
    logger.i({"quantity": "item.quantity"});
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }

  bool _fromnotsameCaffeteria(ProductModel product) => userController
      .userModel.value.cart
      .where((item) => item.cafeteriaId.compareTo(product.caffeteriaid) == 0)
      .isNotEmpty;

  // void makeOrder() async {
  //   CartItemModel cart = userController.userModel.value.cart.first;
  //   if (userController.userModel.value.cart.isNotEmpty) {
  //     final doc = FirebaseFirestore.instance.collection("orders").doc();
  //     final jason = {
  //       "payment": false,
  //       "served": false,
  //       "cafeteriaid": cart.cafeteriaId.toString(),
  //       "order": userController.userModel.value.cart
  //           .map((e) => e.toJsonOreder())
  //           .toList(),
  //       "orderid": doc.id,
  //       "createdby": userController.userModel.value.name,
  //       "time": DateTime.now().toString(),
  //       "status": "notDone",
  //       "useremail": userController.userModel.value.email,
  //       "totalprice": cartController.totalCartPrice.toString(),
  //       "userid": userController.userModel.value.id,
  //     };
  //     await doc.set(jason);
  //     clearcart();
  //   } else {
  //     Get.snackbar("The cart is empty", "you cant order an empty cart");
  //   }
  // }

  // void makePayOrder() async {
  //   CartItemModel cart = userController.userModel.value.cart.first;
  //   if (userController.userModel.value.cart.isNotEmpty) {
  //     final doc = FirebaseFirestore.instance.collection("orders").doc();
  //     final jason = {
  //       "payment": true,
  //       "served": false,
  //       "cafeteriaid": cart.cafeteriaId.toString(),
  //       "order": userController.userModel.value.cart
  //           .map((e) => e.toJsonOreder())
  //           .toList(),
  //       "orderid": doc.id,
  //       "createdby": userController.userModel.value.name,
  //       "time": DateTime.now().toString(),
  //       "status": "notDone",
  //       "useremail": userController.userModel.value.email,
  //       "totalprice": cartController.totalCartPrice.toString(),
  //       "userid": userController.userModel.value.id,
  //     };
  //     await doc.set(jason);
  //     clearcart();
  //   } else {
  //     Get.snackbar("The cart is empty", "you cant order an empty cart");
  //   }
  // }

  void makePayOrder() async {
    CartItemModel cart = userController.userModel.value.cart.first;
    if (userController.userModel.value.cart.isNotEmpty) {
      final doc = FirebaseFirestore.instance.collection("orders").doc();
      final jason = {
        "payment": true,
        "served": false,
        "cafeteriaid": cart.cafeteriaId.toString(),
        "order": userController.userModel.value.cart
            .map((e) => e.toJsonOreder())
            .toList(),
        "orderid": doc.id,
        "createdby": userController.userModel.value.name,
        "time": DateTime.now().toString(),
        "status": "notDone",
        "useremail": userController.userModel.value.email,
        "totalprice": cartController.totalCartPrice.toString(),
        "userid": userController.userModel.value.id,
        "reciveId": 0, // initialize reciveId to 0
      };

      // Increment the value of reciveId
      QuerySnapshot orders = await FirebaseFirestore.instance
          .collection("orders")
          .where("cafeteriaid", isEqualTo: cart.cafeteriaId.toString())
          .orderBy("reciveId", descending: true)
          .limit(1)
          .get();
      if (orders.docs.isNotEmpty) {
        Map<String, dynamic> data =
            orders.docs.first.data() as Map<String, dynamic>;
        int maxReciveId = data["reciveId"] as int;
        jason["reciveId"] = maxReciveId + 1;
      } else {
        jason["reciveId"] = 1;
      }

      // Save the order to Firestore
      await doc.set(jason);
      clearcart();
    }
  }

  void makeOrder() async {
    CartItemModel cart = userController.userModel.value.cart.first;
    if (userController.userModel.value.cart.isNotEmpty) {
      final doc = FirebaseFirestore.instance.collection("orders").doc();
      final jason = {
        "payment": false,
        "served": false,
        "cafeteriaid": cart.cafeteriaId.toString(),
        "order": userController.userModel.value.cart
            .map((e) => e.toJsonOreder())
            .toList(),
        "orderid": doc.id,
        "createdby": userController.userModel.value.name,
        "time": DateTime.now().toString(),
        "status": "notDone",
        "useremail": userController.userModel.value.email,
        "totalprice": cartController.totalCartPrice.toString(),
        "userid": userController.userModel.value.id,
        "reciveId": 0, // initialize reciveId to 0
      };

      // Increment the value of reciveId
      QuerySnapshot orders = await FirebaseFirestore.instance
          .collection("orders")
          .where("cafeteriaid", isEqualTo: cart.cafeteriaId.toString())
          .orderBy("reciveId", descending: true)
          .limit(1)
          .get();
      if (orders.docs.isNotEmpty) {
        Map<String, dynamic> data =
            orders.docs.first.data() as Map<String, dynamic>;
        int maxReciveId = data["reciveId"] as int;
        jason["reciveId"] = maxReciveId + 1;
      } else {
        jason["reciveId"] = 1;
      }

      await doc.set(jason);
      clearcart();
    }
  }

  void clearcart() {
    try {
      userController.updateUserData({
        "cart": [],
      });
    } catch (e) {
      Get.snackbar("Eroor", "Cannot remove this item");
      debugPrint(e.message);
    }
  }
}
