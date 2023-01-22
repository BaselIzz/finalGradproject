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
  RxMap<ProductModel, List<ProductModel>> Reclist =
      RxMap<ProductModel, List<ProductModel>>();
  List<ProductModel> list = List();

  getrecomander() {
    List<List<double>> descriptionMatrix = [];
    Reclist.clear();

    for (var i = 0; i < productsController.products.length; i++) {
      descriptionMatrix.add([]);
      for (var j = 0; j < productsController.products.length; j++) {
        var similarity = StringSimilarity.compareTwoStrings(
            productsController.products[i].description,
            productsController.products[j].description);
        descriptionMatrix[i].add(similarity);
      }
    }
    List<ProductModel> data = [];
    // Print the similarity scores for the first meal
    for (var i = 0; i < productsController.products.length; i++) {
      for (var j = 0; j < productsController.products.length; j++) {
        if (descriptionMatrix[i][j] >= 0.4 && i != j) {
          if (!(productsController.products[i].ProductName ==
              productsController.products[j].ProductName))
            data.add(productsController.products[j]);
        }
      }

      Reclist.putIfAbsent(productsController.products[i], () => data);
    }
  }

  void getRecomandedList(ProductModel productModel) {
    getrecomander();
    for (ProductModel pro in Reclist[productModel]) {
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
}
