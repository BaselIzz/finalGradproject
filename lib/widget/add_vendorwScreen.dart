import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/manger_screen.dart';
import 'package:gradutionfinalv/widget/addvendorwidget.dart';

import '../constants/controllers.dart';

class AddVendorScreen extends StatelessWidget {
  const AddVendorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Create Vendor account",
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
                    accountName:
                        Text(userController.mangerModel.value.userName ?? ""),
                    accountEmail: Text(
                        userController.mangerModel.value.userEmail ?? ""))),
                ListTile(
                  onTap: () {
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
                    Get.offAll(() => MangerScreen());
                  },
                  leading: Icon(
                    Icons.table_chart,
                    color: Colors.black87,
                  ),
                  title: Text("Manger"),
                ),
              ],
            ),
          ),
          body: AddVendorWidget(),
        ));
  }
}
