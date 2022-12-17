import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/widget/single_product.dart';

import '../constants/controllers.dart';
import '../model/product.dart';

class ProductsWidget extends StatelessWidget {
  String cafeteriaId;
  ProductsWidget(this.cafeteriaId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
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
    );
  }
}
