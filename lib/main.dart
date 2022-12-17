import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/firebase.dart';
import 'package:gradutionfinalv/controllers/cart_controller.dart';
import 'package:gradutionfinalv/controllers/product_controller.dart';

import 'app.dart';
import 'controllers/appController.dart';
import 'controllers/authController.dart';
import 'controllers/caffetria_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AppController());
    Get.put(UserController());
    Get.put(CaffetriaController());
    Get.put(ProductsController());
    Get.put(CartController());
  });

  runApp(App());
}
