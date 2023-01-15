import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/controllers/orderController.dart';
import 'package:gradutionfinalv/model/order.dart';

import 'orderWidgetnew.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
        scrollDirection: Axis.vertical,
        children: orderController.orders
            .where((p0) =>
                p0.status == "notDone" &&
                p0.cafeteriaid == userController.vendormodel.value.caffeteriaid)
            .map((orderModel order) {
          return Orderwidgetnew(order);
        }).toList()));
  }
}
