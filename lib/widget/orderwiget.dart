import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/controllers/orderController.dart';
import 'package:gradutionfinalv/model/order.dart';

import 'orderWidgetnew.dart';

class Orderwidget extends StatelessWidget {
  const Orderwidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          children: orderController.orders
              .map((orderModel order) => Orderwidgetnew(order))
              .toList(),
        ));
  }
}
