import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/controllers/SplayTreeController.dart';
import 'package:gradutionfinalv/controllers/product_controller.dart';
import 'package:gradutionfinalv/model/SplayTreeDocs.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';
import 'package:gradutionfinalv/widget/mostViewedWidgetl.dart';
import 'package:gradutionfinalv/widget/single_product.dart';

import '../constants/controllers.dart';
import '../model/product.dart';

class ProductsWidget extends StatelessWidget {
  String cafeteriaId;
  ProductsWidget(this.cafeteriaId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x = caffetriaController.prodFormSplayTree.length;

    List<ProductModel> prod = caffetriaController
        .getCaffeteria(cafeteriaId)
        .splayTree
        .topKFrequent(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "The Most Products Viewed ",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: caffetriaController.prodFormSplayTree
                  .where((p0) => p0.SplayTreeDocsdlist.any(
                      (ProductModel p) => p.caffeteriaid == cafeteriaId))
                  .expand((SplayTreeDocs p0) => p0.SplayTreeDocsdlist)
                  .where((ProductModel p) => p.caffeteriaid == cafeteriaId)
                  .map((ProductModel product) {
                return MostViewedWidget(
                  productModel: product,
                  imagePath: product.ProductPhoto,
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Product for  ${caffetriaController.getCaffeterianame(cafeteriaId)}",
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Obx(
            () => GridView.count(
                crossAxisCount: 2,
                childAspectRatio: .63,
                padding: const EdgeInsets.all(10),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 10,
                children: productsController.products
                    .where((p0) => p0.caffeteriaid == cafeteriaId)
                    .map((ProductModel product) {
                  return SingleProductWidget(
                    product: product,
                  );
                }).toList()),
          ),
        ),
      ],
    );
  }
}
