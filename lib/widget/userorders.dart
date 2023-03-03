import 'package:flutter/material.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/order.dart';
import 'package:gradutionfinalv/model/order_item.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

class UserOrders extends StatelessWidget {
  orderModel order;
  UserOrders(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(
                color: order.status == "Done" ? Colors.green : Colors.red)),
        child: Column(children: [
          CustomText(
            text: "Items: ${getorders(order.order)}",
          ),
          CustomText(
            text:
                "Date Order: ${order.time.split(".").getRange(0, 1).toString().replaceAll(RegExp("[()]"), "")}",
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(text: "Status:"),
              Icon(order.status == "Done" ? Icons.done : Icons.clear,
                  color: order.status == "Done" ? Colors.green : Colors.red)
            ],
          ),
          MaterialButton(
            onPressed: () {
              orderController.reorder(order);
            },
            color: order.status == "Done" ? Colors.green : Colors.red,
            minWidth: 100,
            child: const Text(
              "Re Order",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

  getorders(List<OrderItemModel> orders) {
    String totalorders = "";
    for (var item in orders) {
      totalorders += "${item.name}, ";
    }
    return totalorders;
  }
}
