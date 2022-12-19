import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/controllers/orderController.dart';
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
        child: ElevatedButton(
      child: Text("Confrom"),
      onPressed: () {
        print(widget.order.cafeteriaid);
        print(widget.order.orderid);
        print(widget.order.status);
        print(widget.order.totalprice);
        print(widget.order.time);
        print(widget.order.useremail);
        print(widget.order.userid);
        orderController.updateState(widget.order.orderid);
        //sendPushMessage(devicetoken, "Hello World", "Hello");
      },
    ));
  }

  void saveToken(String token) async {
    await firebaseFirestore
        .collection("UserTokens")
        .doc(widget.order.orderid)
        .set({
      'token': token,
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        devicetoken = token;
      });

      print("my token is $devicetoken");

      saveToken(token);
    });
  }

  @override
  void initState() {
    RequestPermission();
    getToken();
    // initInfo();
  }

  void RequestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      ("User declined or has not accepted permission");
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": 'application/json',
          'Authorization':
              'key=AAAAVLVNjEk:APA91bFMsqbKv-APFbkmDJ3EIdpPrXCBDVaw2ZBVfiWmcq63vdZjQMa5ALAC_xZagCCEbpJEfPnpngSd6253zdNI6tt9nq6bxw0XpkYGK8LB2EzneH4oZCvuzOH_t7Y1i0WXrHqZBfyA'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
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
}
