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
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: CustomText(
                text: "Meal Order",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(
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
                        if (userController.userModel.value.cart.isEmpty) {
                          Get.snackbar(
                              "Nothing In Cart", "You Can't Order Nothing");
                        } else {
                          showModalBottomSheet(
                              anchorPoint: Offset(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(40),
                                    bottom: Radius.circular(40)),
                              ),
                              context: context,
                              builder: ((context) => Container(
                                    padding: EdgeInsets.all(40),
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const CustomText(
                                        text: "Payment",
                                        size: 20,
                                        weight: FontWeight.w600,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      MaterialButton(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'asset/images/images.jfif',
                                              width: 50,
                                            ),
                                            Text(
                                              " Visa",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        height: 100,
                                        minWidth: 40,
                                        onPressed: () {
                                          cartController.makePayOrder();
                                        },
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      MaterialButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'asset/images/cash.png',
                                              width: 50,
                                            ),
                                            const Text(
                                              " Cash",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        height: 100,
                                        minWidth: 20,
                                        onPressed: () {
                                          cartController.makeOrder();
                                        },
                                        color: Colors.black,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ),
                                    ]),
                                  )));
                        }
                      }),
                )))
      ],
    );
  }
}
