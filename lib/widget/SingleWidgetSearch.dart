import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/products.screen.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

import '../constants/controllers.dart';
import '../model/product.dart';

class SingleProductSearch extends StatelessWidget {
  final ProductModel product;

  const SingleProductSearch({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: const Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  product.ProductPhoto,
                  width: 100,
                  height: 100,
                )),
          ),
          CustomText(
            text: product.ProductName,
            size: 18,
            weight: FontWeight.bold,
          ),
          CustomText(
            text: orderController.productinoreder(product) > 0
                ? 'Time To Done: ${int.parse(product.ProductTime) * orderController.productinoreder(product)}m'
                : 'Time To Done: ${product.ProductTime} m',
            color: Colors.black,
          ),
          const SizedBox(
            height: 5,
          ),
          Obx(() => CustomText(
                text:
                    " Product in order: ${orderController.productinoreder(product).toString()}",
              )),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: "₪${product.ProductPrice}",
                  size: 22,
                  weight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Get.to(ProductScreens(product.caffeteriaid));
                  })
            ],
          ),
        ],
      ),
    );
  }
}
