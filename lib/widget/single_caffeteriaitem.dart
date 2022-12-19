import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/widget/caffeteriashow.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

class SingleCaffeteriaitem extends StatelessWidget {
  final CafeteriaModel Caffeteia;
  const SingleCaffeteriaitem({Key key, this.Caffeteia}) : super(key: key);

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
                    "https://heavy.com/wp-content/uploads/2020/12/GettyImages-133281966-e1608688624818.jpg?quality=65&strip=all",
                    width: 1200,
                    height: 100,
                  )),
            ),
            CustomText(
              text: Caffeteia.cafeteriaName,
              size: 18,
              weight: FontWeight.bold,
            ),
            // CustomText(
            //   text: '${Caffeteia.}',
            //   color: Colors.grey,
            // ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // // Padding(
                // //   padding: const EdgeInsets.only(left: 8.0),
                // //   child: CustomText(
                // //     text: "₪${product.ProductPrice}",
                // //     size: 22,
                // //     weight: FontWeight.bold,
                // //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      //      cartController.addProductTocart(product);
                    })
              ],
            ),
          ],
        ));
  }
}
