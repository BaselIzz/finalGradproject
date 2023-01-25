import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/doneorderScreen.dart';
import 'package:gradutionfinalv/screens/order_screen.dart';
import 'package:gradutionfinalv/screens/showProducts.dart';
import 'package:gradutionfinalv/screens/showproduct.dart';

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
        title: Center(
          child: Text(
            "Vendor",
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
                accountName: Text(userController.vendormodel.value.name ?? ""),
                accountEmail:
                    Text(userController.vendormodel.value.email ?? ""))),
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
                Get.offAll(doneOrderScreen());
              },
              leading: Icon(
                Icons.table_chart,
                color: Colors.black87,
              ),
              title: Text("FinshedOrder"),
            ),
            ListTile(
              leading: Icon(
                Icons.table_chart,
                color: Colors.black87,
              ),
              onTap: (() => Get.offAll(ShowProducts())),
              title: Text("ProductsTable"),
            )
          ],
        ),
      ),
      body: OrderWidget(),
    );
  }
}
