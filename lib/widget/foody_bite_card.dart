import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/screens/products.screen.dart';
import 'package:gradutionfinalv/widget/ProductWidget.dart';

import '../values/values.dart';
import 'card_tags.dart';

class FoodyBiteCard extends StatelessWidget {
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
  final CafeteriaModel caffeteria;
  FoodyBiteCard({
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
    this.caffeteria,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductScreens(caffeteria.cafeteriaId));
      },
      child: Container(
        width: width,
        height: cardHeight,
        child: Card(
          elevation: cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Stack(children: <Widget>[
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      imagePath,
                      width: MediaQuery.of(context).size.width,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Sizes.MARGIN_16,
                      vertical: Sizes.MARGIN_16,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            // Container(decoration:,),
                            // Text(
                            //   "",
                            //   textAlign: TextAlign.left,
                            //   style: Styles.customTitleTextStyle(
                            //     color: AppColors.headingText,
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: Sizes.TEXT_SIZE_20,
                            //   ),
                            // ),
                            //          SizedBox(width: Sizes.WIDTH_4),
                            // CardTags(
                            //   title: caffeteria.name,
                            //   decoration: BoxDecoration(
                            //     gradient: Gradients.secondaryGradient,
                            //     boxShadow: [
                            //       Shadows.secondaryShadow,
                            //     ],
                            //   ),
                            // ),
                            SizedBox(width: 5.0),
                            Spacer(
                              flex: 1,
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(height: 12.0),
                                ),
                              ],
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
