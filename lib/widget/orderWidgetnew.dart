import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/controllers/orderController.dart';
import 'package:gradutionfinalv/model/order_item.dart';
import 'package:gradutionfinalv/widget/orderitemwidget.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gradutionfinalv/constants/firebase.dart';
import 'package:gradutionfinalv/model/order.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

import 'orderwidgetshow.dart';

TextEditingController username = TextEditingController();
TextEditingController title = TextEditingController();
TextEditingController body = TextEditingController();

class Orderwidgetnew extends StatefulWidget {
  final orderModel order;
  Orderwidgetnew(this.order, {Key key}) : super(key: key);

  @override
  State<Orderwidgetnew> createState() => _OrderwidgetnewState();
}

class _OrderwidgetnewState extends State<Orderwidgetnew> {
  var deviceToken = " ";
  Random rand;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.green,
        width: 2.0,
      )),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        CustomText(
          text: " Order Number  ${widget.order.recivedId} ",
          weight: FontWeight.w900,
          size: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomText(
          text: "CreatedBy: ${widget.order.createdby}",
          weight: FontWeight.w700,
          size: 17,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            DataTable(columnSpacing: 10, dataRowHeight: 100, columns: const [
              DataColumn(
                  label: Text(
                "time",
                style: TextStyle(fontSize: 20),
              )),
              DataColumn(
                  label: Text(
                "price",
                style: TextStyle(fontSize: 20),
              )),
            ], rows: [
              DataRow(cells: [
                DataCell(Text(
                  widget.order.time
                      .split(".")
                      .getRange(0, 1)
                      .toString()
                      .replaceAll(RegExp("[()]"), ""),
                  style: const TextStyle(fontSize: 15),
                )),
                DataCell(Text(widget.order.totalprice))
              ])
            ]),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 20,
        ),
        DataTable(
            dividerThickness: 1,
            columnSpacing:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 10
                    : 80,
            horizontalMargin: 10,
            border: const TableBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            columns: const [
              DataColumn(
                  label: Text(
                "Name ",
                style: TextStyle(fontSize: 15),
              )),
              DataColumn(label: Text("image", style: TextStyle(fontSize: 15))),
              DataColumn(
                  label: Text("Quatity", style: TextStyle(fontSize: 15))),
              DataColumn(label: Text("Price", style: TextStyle(fontSize: 15)))
            ],
            rows: List.generate(widget.order.order.length, (index) {
              OrderItemModel orderr = widget.order.order[index];
              return DataRow(cells: [
                DataCell(Text(
                  orderr.name.toString().toLowerCase(),
                  style: const TextStyle(fontSize: 20),
                )),
                DataCell(Image.network(
                  orderr.image,
                  height: 50,
                  width: 50,
                )),
                DataCell(Text(
                  orderr.quantity,
                  style: const TextStyle(fontSize: 20),
                )),
                DataCell(Text(
                  orderr.cost,
                  style: const TextStyle(fontSize: 20),
                ))
              ]);
            })),
        const SizedBox(
          height: 40,
        ),
        const SizedBox(
          height: 20,
        ),
        DataTable(
            columns: const [
              DataColumn(
                  label: Text(
                "Name",
                style: TextStyle(
                  fontSize: 15,
                ),
              )),
              DataColumn(
                  label: Text(
                "Addition",
                style: TextStyle(fontSize: 15),
              ))
            ],
            rows: List.generate(widget.order.order.length, (index) {
              OrderItemModel orderr = widget.order.order[index];
              return DataRow(cells: [
                DataCell(Text(
                  orderr.name.toString().toLowerCase(),
                  style: TextStyle(fontSize: 12),
                )),
                DataCell(Text(
                  "${orderr.notice.toLowerCase()}",
                  style: TextStyle(fontSize: 12),
                ))
              ]);
            })),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
            onPressed: () {
              orderController.updateState(widget.order.orderid);
              getDeviceToken(widget.order.userid);
              sendPushMessage(
                  deviceToken,
                  "Your Order has been Done With ID :${widget.order.recivedId}  ",
                  "Notification From ${caffetriaController.getCaffeterianame(widget.order.cafeteriaid)}");
            },
            child: const Text("Done")),
      ]),
    );
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    getDeviceToken(widget.order.userid);

    super.initState();
  }

  Future getDeviceToken(String userId) async {
    firebaseFirestore
        .collection("UserTokens")
        .doc(userId)
        .get()
        .then((value) => deviceToken = value.get('token'));
  }

  void sendPushMessage(String token, String body, String title) async {
    var serverToken =
        "AAAAVLVNjEk:APA91bH1MVbh1rr5YkdyWIzvgnOfmD5eVH_C-wcOf_QKG5qaf4HJBPXVr6gTs3QUDjrCUuncLs-ieiZ_HTiCfWv55LFDb6kkZ6dLfIIeoZNg-GPq5cB6RrzHqsOiKlVax6ER25DqSM-c";

    try {
      await http.post(
        //finalcafeteriasystem
        //https://fcm.googleapis.com/fcm/send
        //https://fcm.googleapis.com/v1/projects/finalcafeteriasystem/messages:send
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': "done",
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }

  void sendMessageForAllusers(String body, String title) async {
    var serverToken =
        "AAAAVLVNjEk:APA91bGVcOv-6S0OwzCBKD4eG20OD3W8zOXxTfCSeVIBtl6Sce7Pe4OcNkSV3jxhQ9XDB6Ix43jGdfrtJ3yRZUi1yppHAikqs_FkKGb1nJZebEp-na50STJf2I04XGbEpDdR2tPRnRjM";
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': "done",
            },
            "to": "/topics/birzeit"
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }
}
