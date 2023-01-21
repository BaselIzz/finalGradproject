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
  // List<Category> categorys = [
  //   Category("SoftDrinks",
  //       "https://th.bing.com/th/id/R.a779dfc4a5ba54b3f92f274bd265a833?rik=9%2br3rXteMLqMcA&pid=ImgRaw&r=0"),
  //   Category("Pizza",
  //       "https://heavy.com/wp-content/uploads/2020/12/GettyImages-133281966-e1608688624818.jpg?quality=65&strip=all"),
  //   Category("HotDrinks",
  //       "https://th.bing.com/th/id/OIP._VvmTz5uvGZ0J9drdmGtQAHaE5?pid=ImgDet&rs=1")
  // ];

  @override
  Widget build(BuildContext context) {
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
            height: 50,
          ),
          HeadingRow(
            onTapOfNumber: () {},
            title: "Recmoandation Meals ",
            number: 'View more (${recommendationController.Reclist.length})',
          ),
          SizedBox(
            height: 16,
          ),
          Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              child: RecomandedItems()),
        ],
      ),
    );
  }
}
