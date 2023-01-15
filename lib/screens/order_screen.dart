import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/order.dart';
import 'package:gradutionfinalv/widget/userorders.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView(
          children: orderController.orders
              .where((orderModel p0) =>
                  p0.userid == userController.userModel.value.id)
              .map((orderModel order) => UserOrders(order))
              .toList())),
    );
  }
}
