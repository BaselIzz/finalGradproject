import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
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

var devicetoken = " ";

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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.green,
        width: 2.0,
      )),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Text(" CreatedBy: ${widget.order.createdby} ",
            style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            DataTable(columnSpacing: 10, dataRowHeight: 100, columns: const [
              DataColumn(
                  label: Text(
                "time",
                style: TextStyle(fontSize: 20),
                //  overflow: TextOverflow.fade,
              )),
              DataColumn(
                  label: Text(
                "price",
                style: TextStyle(fontSize: 20),
                //  overflow: TextOverflow.visible,
              )),
            ], rows: [
              DataRow(cells: [
                DataCell(Text(
                  "${widget.order.time}",
                  style: TextStyle(fontSize: 15),
                )),
                DataCell(Text("${widget.order.totalprice}"))
              ])
            ]),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        DataTable(
            dividerThickness: 1,
            columnSpacing: 40,
            horizontalMargin: 10,
            border: TableBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            columns: [
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
                  orderr.name.toString(),
                  style: TextStyle(fontSize: 27),
                )),
                DataCell(Image.network(
                  orderr.image,
                  height: 60,
                )),
                DataCell(Text(
                  orderr.quantity,
                  style: TextStyle(fontSize: 20),
                )),
                DataCell(Text(
                  orderr.cost,
                  style: TextStyle(fontSize: 20),
                ))
              ]);
            })),
        SizedBox(
          height: 40,
        ),
        ElevatedButton(
            onPressed: () {
              getToken();
              sendPushMessage(devicetoken, "hello wrold", "hello");
              showDoneDialog();
              // FirebaseMessaging.onMessage.listen((event) {
              //   print("hello");
              //   //  print(event.data.toString());
              //   print(event.notification.body);
              // });
            },
            child: Text("Done"))
      ]),
    );
  }

  Future showDoneDialog() async {
    await FirebaseMessaging.onMessage.listen(
      (event) => print("hhhhhhhafdadsadsad${event.notification.body}"),
    );
  }

  Future saveToken(String token) async {
    await firebaseFirestore
        .collection("UserTokens")
        .doc(widget.order.userid)
        .set({
      'token': token,
    });
  }

  Future getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        devicetoken = token;
      });

      print("my token is $devicetoken");

      saveToken(devicetoken);
    });
  }

  @override
  void initState() {
    getToken();
    // initInfo();
  }

  void sendPushMessage(String token, String body, String title) async {
    var serverToken =
        "AAAAVLVNjEk:APA91bFMsqbKv-APFbkmDJ3EIdpPrXCBDVaw2ZBVfiWmcq63vdZjQMa5ALAC_xZagCCEbpJEfPnpngSd6253zdNI6tt9nq6bxw0XpkYGK8LB2EzneH4oZCvuzOH_t7Y1i0WXrHqZBfyA";
    try {
      final r = await http.post(
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
            "to": serverToken
          },
        ),
      );
      if (r.statusCode == 200) {
        print("send__________________");
      }
      print(
          "_______________________________________${r.statusCode.toString()}");
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }

  void sendMessageForAllusers(String body, String title) async {
    var serverToken =
        "AAAAVLVNjEk:APA91bFMsqbKv-APFbkmDJ3EIdpPrXCBDVaw2ZBVfiWmcq63vdZjQMa5ALAC_xZagCCEbpJEfPnpngSd6253zdNI6tt9nq6bxw0XpkYGK8LB2EzneH4oZCvuzOH_t7Y1i0WXrHqZBfyA";
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
