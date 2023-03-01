import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';

import '../constants/firebase.dart';
import '../model/product.dart';
import '../utils/splayTree.dart';

class ProductsController extends GetxController {
  static ProductsController instace = Get.find();

  RxList<ProductModel> products = RxList<ProductModel>([]);

  //SplayTree<ProductModel> splayTree = SplayTree<ProductModel>();
  List<ProductModel> Top10meals = RxList<ProductModel>([]);
  HashMap<String, List<ProductModel>> mapForTop10ForEachCafeteria = HashMap();

  List<String> show = <String>[];
  HashMap<String, List<String>> hashMap = HashMap<String, List<String>>();

  String collection = "product";
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    products.bindStream(getAllProducts());
    print(products.length);
    print("inside product controller");
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((event) =>
          event.docs.map((item) => ProductModel.fromMap(item.data())).toList());

  // ignore: missing_return
  Stream<List<ProductModel>> fillmapForTop10ForEachCafeteria() {
    for (int i = 0; i < caffetriaController.cafeterias.length; i++) {
      for (int j = 0; j < products.length; j++) {
        if (caffetriaController.cafeterias[i].cafeteriaId ==
            products[j].caffeteriaid) {
          caffetriaController.cafeterias[i].splayTree.insert(products[j]);
        }
      }
      if (caffetriaController.cafeterias[i].splayTree.size != 0) {
        List<ProductModel> list =
            caffetriaController.cafeterias[i].splayTree.topKFrequent(2);

        mapForTop10ForEachCafeteria.putIfAbsent(
            caffetriaController.cafeterias[i].cafeteriaId, () => list);
        Top10meals = mapForTop10ForEachCafeteria[
            caffetriaController.cafeterias[i].cafeteriaId];
      }
    }
  }

  Stream<List<ProductModel>> getProductsByTemprture() {
    if (caffetriaController.tempOnCelsuis > 0 &&
        caffetriaController.tempOnCelsuis <= 15) {
      return firebaseFirestore
          .collection(collection)
          .where("tempStatus", isEqualTo: "cold")
          .snapshots()
          .map((event) =>
              event.docs.map((e) => ProductModel.fromMap(e.data())).toList());
    } else if (caffetriaController.tempOnCelsuis > 15 &&
        caffetriaController.tempOnCelsuis <= 25) {
      return firebaseFirestore
          .collection(collection)
          .where("tempStatus", isEqualTo: "between")
          .snapshots()
          .map((event) =>
              event.docs.map((e) => ProductModel.fromMap(e.data())).toList());
    } else {
      return firebaseFirestore
          .collection(collection)
          .where("tempStatus", isEqualTo: "hot")
          .snapshots()
          .map((event) =>
              event.docs.map((e) => ProductModel.fromMap(e.data())).toList());
    }
  }

  void addproduct(ProductModel product) async {
    if (isadded(product)) {
      Get.snackbar("The item is already added ",
          "${product.ProductName} is already exist  ");
      return;
    }

    final addprd = firebaseFirestore.collection(collection).doc();
    final json = {
      "cafetria_id": product.caffeteriaid,
      "id": addprd.id,
      "product_photo": product.ProductPhoto,
      "product_name": product.ProductName,
      "product_price": product.ProductPrice,
      "is_Exist": product.is_Exist,
      "product_time": product.ProductTime,
      "product_description": product.description
    };
    await addprd.set(json);
  }

  void updateStatus(String id, bool status) {
    firebaseFirestore
        .collection(collection)
        .doc(id)
        .update({"is_Exist": !status});
  }

  void getCaferteriaIdsfromPrdouct() async {
// هاي عشات لما يكبس على الميل في الريكمونديشن يفتح ع واجهة كافتيريات

    List<ProductModel> list =
        products.where((p0) => p0.ProductName == "ms7ab").toList();
    print(list.length);
    list.forEach((element) {
      show.add(element.caffeteriaid);
    });

    //  products.where((p0) => p0.ProductName == products[i].ProductName).forEach((element) {
    //  hashMap.putIfAbsent(products[i].ProductName, () => products[i].caffeteriaid)
    // })
    //
  }

  void getmeso() async {
    for (int i = 0; i < productsController.products.length; i++) {
      List<String> list_of_id = <String>[];
      list_of_id.add(productsController.products[i].caffeteriaid);
      for (int j = 0; j < productsController.products.length; j++) {
        if (productsController.products[i].ProductName ==
                productsController.products[j].ProductName &&
            i != j) {
          list_of_id.add(productsController.products[j].caffeteriaid);
        }
      }
      hashMap[productsController.products[i].ProductName] = list_of_id;
    }
  }

  // Stream<List<CafeteriaModel>>  getcafeteriaAfterPressingInRecomandedmeal(ProductModel productModel) async =>  firebaseFirestore.collection(collection)
  //       .where("id" , whereIn: hashMap[productModel.ProductName]).snapshots()
  //       .map((event) => event.docs
  //       .map((e) => CafeteriaModel.fromSnapshot(e.data())).toList());

  Stream<List<CafeteriaModel>> getcafeteriaAfterPressingInRecomandedmeal(
          String productname) =>
      firebaseFirestore
          .collection("cafeteria")
          .where("id", whereIn: hashMap[productname])
          .snapshots()
          .map((event) => event.docs
              .map((e) => CafeteriaModel.fromSnapshot(e.data()))
              .toList());

  /*


   Stream<List<CafeteriaModel>> getAllcafeteria() => firebaseFirestore
      .collection(collection)
      .snapshots()
      .map((event) => event.docs
          .map((item) => CafeteriaModel.fromSnapshot(item.data()))
          .toList());
  */

  bool isadded(ProductModel product) {
    return products.where((p0) => p0 == product).isNotEmpty;
  }

  // Stream<List<ProductModel>> getforcaff() => firebaseFirestore
  //     .collection(collection)
  //     .where("cafeteriaId", isEqualTo: "A")
  //     .snapshots()
  //     .map((event) =>
  //         event.docs.map((e) => ProductModel.fromMap(e.data())).toList());

  //// here the code for the diply the product and manipluate  of the ingrdeints of its like incresae and decresae specifc ingreadints

}
