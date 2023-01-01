import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

import '../model/order_item.dart';

class orderitemwidget extends StatelessWidget {
  final OrderItemModel order;
  const orderitemwidget({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            order.image,
            width: 80,
          ),
        ),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                padding: EdgeInsets.only(left: 14),
                child: CustomText(
                  text: order.name,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: order.quantity.toString(),
                  ),
                ),
              ],
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CustomText(
            text: "₪${order.cost}",
            size: 22,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
