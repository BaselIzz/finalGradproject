import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/firebase.dart';
import 'package:gradutionfinalv/controllers/cart_controller.dart';
import 'package:gradutionfinalv/controllers/orderController.dart';
import 'package:gradutionfinalv/controllers/product_controller.dart';
import 'package:gradutionfinalv/firebase_option.dart';

import 'app.dart';
import 'controllers/appController.dart';
import 'controllers/authController.dart';
import 'controllers/caffetria_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initialization.then((value) {
    Get.put(AppController());
    Get.put(UserController());
    Get.put(CaffetriaController());
    Get.put(ProductsController());
    Get.put(CartController());
    Get.put(OrderController());
  });

  runApp(App());
}
