import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/controllers/product_controller.dart';
import 'package:gradutionfinalv/main.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/screens/search_screen.dart';

import '../constants/controllers.dart';
import '../values/values.dart';
import '../widget/card_tags.dart';
import '../widget/dark_overlay.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

int index = 0;

class _MainScreenState extends State<MainScreen> {
  // final FirebaseService firebaseService = FirebaseService();
  @override
  void initState() {
    // firebaseService.initialize();
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((value) {
      if (!value) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    OrderScreen()
  ];
  List<Widget> item = [
    const Icon(
      Icons.home_outlined,
      semanticLabel: "HomeScreen",
      size: 30,
    ),
    const Icon(
      Icons.search,
      semanticLabel: "SerchScreem",
      size: 30,
    ),
    const Icon(
      Icons.shopping_cart,
      semanticLabel: "shopScreen",
      size: 30,
    ),
    const Icon(
      Icons.shopping_bag_sharp,
      semanticLabel: "orderScreen",
      size: 30,
    )
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 1,
        channelKey: "alerts",
        title: message.notification.title,
        body: message.notification.body,
      ));
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    recommendationController.getissa();
    productsController.getmeso();
    productsController.fillmapForTop10ForEachCafeteria();
    caffetriaController.prodFormSplayTree
        .bindStream(caffetriaController.getProductFormsplayTree());
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(productsController.mapForTop10ForEachCafeteria.length);
    caffetriaController.getTemprture();

    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            screens[index].toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Obx(() => UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(userController.userModel.value.name ?? ""),
                accountEmail:
                    Text(userController.userModel.value.email ?? ""))),
            ListTile(
              onTap: () {
                print("__________________________________Signout");

                userController.signOut();
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black87,
              ),
              title: Text("Log out"),
            ),
            ListTile(
              onTap: () {
                recommendationController.clearHistory();
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black87,
              ),
              title: Text("Clear Recomandation"),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 500),
          animationCurve: Curves.fastOutSlowIn,
          items: item,
          height: 70,
          backgroundColor: Colors.transparent,
          index: index,
          onTap: (value) => setState(() {
                index = value;
              })),
      backgroundColor: AppColors.grey,
      body: screens[index],
    );
  }
}
