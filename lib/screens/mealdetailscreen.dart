import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/screens/home_screen.dart';

import '../controllers/MealDetailController.dart';

class MealDetailScreen extends GetView<MealDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.productModel.ProductName),
        shadowColor: Color.fromARGB(2, 2, 2, 0),
        backgroundColor: Color.fromARGB(244, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(controller.productModel.ProductPhoto),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                controller.productModel.description,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller.noticeController,
                onChanged: (value) => controller.notice = value,
                decoration: InputDecoration(
                  labelText: "Notice",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.addToCart(
                      controller.productModel, controller.notice);
                  //Get.to(HomeScreen());
                },
                child: Text("Add To Cart"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
