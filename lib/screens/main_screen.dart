import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/controllers/product_controller.dart';
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
  List<Widget> screens = [
    HomeScreen(),
    //SearchScreen(),
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
    recommendationController.getissa();
    productsController.getmeso();
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
            )
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
