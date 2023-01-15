import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/order.dart';
import 'package:gradutionfinalv/widget/finishedorderwidget.dart';

class FinishOrderTable extends StatelessWidget {
  const FinishOrderTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            children: orderController.orders
                .where((p0) =>
                    p0.status == "Done" &&
                    p0.sarved == false &&
                    p0.cafeteriaid ==
                        userController.vendormodel.value.caffeteriaid)
                .map((orderModel order) {
              return FinishedOrderWidget(order);
            }).toList(),
          )),
    );
  }
}
