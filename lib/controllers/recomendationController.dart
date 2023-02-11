import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/constants/firebase.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/model/user.dart';
import 'package:string_similarity/string_similarity.dart';

class RecommendationController extends GetxController {
  static RecommendationController instace = Get.find();
  RxMap<ProductModel, List<ProductModel>> recomanderList =
      RxMap<ProductModel, List<ProductModel>>();
  List<ProductModel> list = <ProductModel>[];

  getissa() {
    List<List<double>> descriptionMatrix = [];
    RxMap<ProductModel, List<ProductModel>> Reclist =
        new RxMap<ProductModel, List<ProductModel>>();

    for (var i = 0; i < productsController.products.length; i++) {
      descriptionMatrix.add([]);
      for (var j = 0; j < productsController.products.length; j++) {
        var similarity = StringSimilarity.compareTwoStrings(
            productsController.products[i].description,
            productsController.products[j].description);
        descriptionMatrix[i].add(similarity);
      }
    }
    for (var i = 0; i < productsController.products.length; i++) {
      List<ProductModel> data = <ProductModel>[];
      Map<String, int> set = Map();
      for (var j = 0; j < productsController.products.length; j++) {
        if (descriptionMatrix[i][j] >= 0.5 &&
            !(set.containsKey(productsController.products[j].ProductName))) {
          data.add(productsController.products[j]);
          set[productsController.products[j].ProductName] = 1;
        }
      }

      Reclist.putIfAbsent(productsController.products[i], () => data);
    }
    recomanderList = Reclist;
  }

  void getRecomandedList(ProductModel productModel) {
    for (ProductModel pro in recomanderList[productModel]) {
      if (!(userController.userModel.value.historyList.contains(pro))) {
        userController.updateUserData({
          "history_list": FieldValue.arrayUnion([pro.toJson()])
        });
      }
    }
  }

  void clearHistory() {
    try {
      userController.updateUserData({
        "history_list": [],
      });
    } catch (e) {
      Get.snackbar("Eroor", "Cannot remove this item");
      debugPrint(e.message);
    }
  }

/* 


*/

}
