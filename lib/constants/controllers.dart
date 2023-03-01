import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradutionfinalv/controllers/caffetria_controller.dart';
import 'package:gradutionfinalv/controllers/orderController.dart';
import 'package:gradutionfinalv/controllers/recomendationController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/MealDetailController.dart';
import '../controllers/appController.dart';
import '../controllers/authController.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/recomendationController.dart';

AppController appController = AppController.instance;
UserController userController = UserController.instance;
//CategoryController categoryController = CategoryController.instance;
ProductsController productsController = ProductsController.instace;
CartController cartController = CartController.instance;
CaffetriaController caffetriaController = CaffetriaController.instace;
OrderController orderController = OrderController.instace;
RecommendationController recommendationController =
    RecommendationController.instace;
MealDetailController mealDetailController = MealDetailController.instace;
