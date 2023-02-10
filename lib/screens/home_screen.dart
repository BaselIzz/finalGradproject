import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/screens/products.screen.dart';
import '../constants/controllers.dart';
import '../model/category.dart';
import '../values/values.dart';
import '../widget/caffeteriaitem.dart';
import '../widget/heading_row.dart';
import '../widget/recomandedItems.dart';
import 'caffeteria_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    recommendationController.getissa();

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Obx(
            () => HeadingRow(
              onTapOfNumber: () {
                Get.to(CaffeteriaScreen());
              },
              title: "Caffeterias",
              number:
                  'View more (${caffetriaController.cafeterias.length.toString()})',
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              child: CaffeteriaItems()),
          SizedBox(
            height: 50,
          ),
          Obx(
            () => HeadingRow(
              onTapOfNumber: () {},
              title: "Recmoandation Meals ",
              number:
                  'View more (${userController.userModel.value.historyList.length})',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
              height: 175,
              width: MediaQuery.of(context).size.width,
              child: RecomandedItems()),
        ],
      ),
    );
  }
}
