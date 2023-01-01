import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/widget/orderitemwidget.dart';

import '../model/order_item.dart';
import 'custom_text.dart';

class OrderWidgetshow extends StatelessWidget {
  List<OrderItemModel> orders;
  OrderWidgetshow(
    this.orders,
  );

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
            Column(
                    children: orders
                        .map((order) => orderitemwidget(order: order))
                        .toList()) ??
                Container(),
          ],
        ),
      ],
    );
  }
}
