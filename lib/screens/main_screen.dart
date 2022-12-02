import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gradutionfinalv/screens/search_screen.dart';

import '../values/values.dart';
import '../widget/card_tags.dart';
import '../widget/dark_overlay.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';

class MainScreen extends StatefulWidget {
  String? email;
  String? password;
  MainScreen({this.email, this.password});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int index = 0;

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    OrderScreen()
  ];
  List<Widget> item = [
    const Icon(
      Icons.home_outlined,
      semanticLabel: "Home",
      size: 30,
    ),
    const Icon(
      Icons.search,
      semanticLabel: "Search",
      size: 30,
    ),
    const Icon(
      Icons.shopping_cart,
      semanticLabel: "shop",
      size: 30,
    ),
    const Icon(
      Icons.shopping_bag_sharp,
      semanticLabel: "order",
      size: 30,
    )
  ];

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              child: Image.asset(
                "asset/images/boiled_eggs.png",
                height: heightOfScreen,
                width: widthOfScreen,
                fit: BoxFit.cover,
              ),
            ),
            DarkOverLay(),
            Positioned(
              top: 0,
              left: 20,
              right: 20,
              bottom: 4,
              child: screens[index],
            ),
          ],
        ),
      ),
    );
  }
}
