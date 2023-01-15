import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/finishordertable.dart';
import 'package:gradutionfinalv/screens/showProducts.dart';
import 'package:gradutionfinalv/screens/showproduct.dart';
import 'package:gradutionfinalv/screens/vendor_screen.dart';

import '../constants/controllers.dart';

class doneOrderScreen extends StatelessWidget {
  const doneOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Finished Order",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(children: [
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
              Get.offAll(VendorScreen());
            },
            leading: Icon(
              Icons.table_chart,
              color: Colors.black87,
            ),
            title: Text("Caffetria"),
          ),
          ListTile(
            onTap: () {
              Get.offAll(() => ShowProducts());
            },
            leading: Icon(
              Icons.table_chart,
              color: Colors.black87,
            ),
            title: Text("ProducttsTable"),
          )
        ]),
      ),
      body: FinishOrderTable(),
    );
  }
}
