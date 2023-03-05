import 'package:flutter/material.dart';
import 'package:gradutionfinalv/constants/firebase.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';

import 'package:gradutionfinalv/utils/splayTree.dart';

import 'package:get/get.dart';

import 'package:gradutionfinalv/widget/custom_text.dart';

import '../constants/controllers.dart';
import '../controllers/MealDetailController.dart';
import '../model/product.dart';
import '../screens/mealDetailScreen.dart';

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;
  final SplayTree splayTree;

  const SingleProductWidget({Key key, this.product, this.splayTree})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
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
          SizedBox(
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
              Visibility(
                visible: product.is_Exist,
                child: IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                    ),
                    onPressed: () {
                      //productsController.fillmapForTop10ForEachCafeteria();

                      recommendationController.getRecomandedList(product);

                      caffetriaController
                          .getCaffeteria(product.caffeteriaid)
                          .splayTree
                          .insert(product);

                      Get.lazyPut(
                          () => MealDetailController(productModel: product));
                      Get.to(() => MealDetailScreen());
                      Addtofirebasefromtree(product);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }

  void Addtofirebasefromtree(ProductModel product) {
    List<ProductModel> prod;
    prod = caffetriaController
        .getCaffeteria(product.caffeteriaid.toString())
        .splayTree
        .topKFrequent(2);

    firebaseFirestore
        .collection("TreeSplayList")
        .doc(product.caffeteriaid)
        .set({"List": prod.map((e) => e.toJson()).toList()});
  }
}
