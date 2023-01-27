import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

import '../constants/controllers.dart';
import '../model/product.dart';

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  const SingleProductWidget({Key key, this.product}) : super(key: key);
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
            text: 'Time To Done: ${product.ProductTime}s',
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
              SizedBox(
                width: 30,
              ),
              IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cartController.addProductTocart(product);
                    recommendationController.getRecomandedList(product);
                  })
            ],
          ),
        ],
      ),
    );
  }
}



/* 
  Firestore.instance
.collection('users').document('xsajAansjdna')
.get()
.then((value) =>
print("Fetched ==>>>"+value.data["username"]));
  
  */
