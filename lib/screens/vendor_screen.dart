import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../widget/orderwiget.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text("Sort By date "),
              IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
            ],
          )
        ],
        title: Center(
          child: Text(
            "Vendor",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),

      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       // Obx(() => UserAccountsDrawerHeader(
      //       //     decoration: BoxDecoration(color: Colors.black),
      //       //     accountName: Text(userController.vendormodel.value.name ?? ""),
      //       //     accountEmail:
      //       //         Text(userController.vendormodel.value.email ?? ""))),
      //       // ListTile(
      //       //   onTap: () {
      //       //     print("__________________________________Signout");

      //       //     userController.signOut();
      //       //   },
      //     //     leading: Icon(
      //     //       Icons.exit_to_app,
      //     //       color: Colors.black87,
      //     //     ),
      //     //     title: Text("Log out"),
      //     //   ),
      //     // ],
      //   ),

      body: OrderWidget(),
    );
  }
}
