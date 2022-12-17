import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/widget/cart_item_widget.dart';
import 'package:gradutionfinalv/widget/custom_btn.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

import '../constants/controllers.dart';

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: "Meal Order",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() =>
                Column(
                  children: userController.userModel.value.cart
                      .map((cartItem) => CartItemWidget(
                            cartItem: cartItem,
                          ))
                      .toList(),
                ) ??
                Container()),
          ],
        ),
        Positioned(
            bottom: 80,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Obx(
                  () => CustomButton(
                      text:
                          "Pay (₪${cartController.totalCartPrice.value.toStringAsFixed(2)})",
                      onTap: () {
                        cartController.makeOrder();
                      }),
                )))
      ],
    );
  }
}
