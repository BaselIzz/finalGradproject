import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/screens/Caffetria_screenForRecomandedMeal.dart';
import 'package:gradutionfinalv/screens/products.screen.dart';
import 'package:gradutionfinalv/widget/ProductWidget.dart';

import '../values/values.dart';
import 'card_tags.dart';

class RecomandedByCar extends StatelessWidget {
  final String status;
  final String imagePath;
  final String cardTitle;
  //final String category;
  final GestureTapCallback onTap;
  final bool isThereStatus;
  final double width;
  final double cardHeight;
  final double imageHeight;
  final double cardElevation;
  final ProductModel productModel;
  RecomandedByCar({
    this.status = "OPEN",
    this.imagePath,
    this.cardTitle,
    // required this.category,
    this.width = 240.0,
    this.cardHeight = 100.0,
    this.imageHeight = 100.0,
    this.onTap,
    this.isThereStatus = true,
    this.cardElevation = 2.0,
    this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RxList<CafeteriaModel> rxList = RxList();
        print(productModel.ProductName);
        rxList.bindStream(
            productsController.getcafeteriaAfterPressingInRecomandedmeal(
                productModel.ProductName));
        Get.to(CafeteriaScreenForRecomandedMeal(productModel.ProductName));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        width: width,
        height: cardHeight,
        child: Card(
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Stack(children: <Widget>[
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imagePath,
                      width: MediaQuery.of(context).size.width,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              productModel.ProductName,
                              textAlign: TextAlign.center,
                              style: Styles.customTitleTextStyle(
                                color: Color.fromARGB(255, 11, 13, 54),
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
