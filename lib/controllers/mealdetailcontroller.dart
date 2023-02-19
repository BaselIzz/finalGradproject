import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/product.dart';

class MealDetailController extends GetxController {
  static MealDetailController instace = Get.find();

  final ProductModel productModel;

  TextEditingController noticeController;

  String notice;

  MealDetailController({this.productModel});

  @override
  void onInit() {
    noticeController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    noticeController.dispose();
    super.onClose();
  }

  void addToCart(ProductModel productModel, String notice) {
    cartController.addProductTocart(productModel, notice);
  }
}
