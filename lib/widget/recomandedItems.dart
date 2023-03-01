import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/widget/recomandedByCar.dart';

class RecomandedItems extends StatelessWidget {
  const RecomandedItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
        scrollDirection: Axis.horizontal,
        children: userController.userModel.value.historyList
                .map((ProductModel productModel) {
              return RecomandedByCar(
                productModel: productModel,
                imagePath: productModel.ProductPhoto,
              );
            }).toList() ??
            Container()));
  }
}
