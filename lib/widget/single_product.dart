import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradutionfinalv/utils/splayTree.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

import '../constants/controllers.dart';
import '../model/product.dart';

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
            text: '${product.ProductTime}',
            color: Colors.grey,
          ),
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
                    // productsController.splayTree.insert(product);
                    //productsController.fillTree();
                    caffetriaController
                        .getCaffeteria(product.caffeteriaid)
                        .splayTree
                        .insert(product);
                    List<ProductModel> listMeso = caffetriaController
                        .getCaffeteria(product.caffeteriaid)
                        .splayTree
                        .topKFrequent(2);
                    for (ProductModel s in listMeso) {
                      print(s.ProductName);
                    }
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
