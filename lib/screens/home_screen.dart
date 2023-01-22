import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/controllers.dart';
import '../model/category.dart';
import '../values/values.dart';
import '../widget/caffeteriaitem.dart';
import '../widget/heading_row.dart';
import 'caffeteria_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    productsController.getrecomander();
    ;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          HeadingRow(
            onTapOfNumber: () {
              Get.to(CaffeteriaScreen());
            },
            title: "Caffeterias",
            number:
                'View more (${caffetriaController.cafeterias.length.toString()})',
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              child: CaffeteriaItems()),
          SizedBox(
            height: 16,
          ),
          HeadingRow(
            onTapOfNumber: () {
              Get.to(CaffeteriaScreen());
            },
            title: "Caffeterias",
            number:
                'View more (${productsController.Reclist.length.toString()})',
          ),
        ],
      ),
    );
  }
}
