import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/admin_screen.dart';
import 'package:gradutionfinalv/widget/addCaffeteriawidget.dart';
import 'package:gradutionfinalv/widget/addMagerwidget.dart';

import '../constants/controllers.dart';
import '../values/values.dart';

class AddMangerScreen extends StatelessWidget {
  const AddMangerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Add manger",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(children: [
          Obx(() => UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text(userController.adminmodel.value.name ?? ""),
              accountEmail: Text(userController.adminmodel.value.email ?? ""))),
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
              Get.offAll(() => const AdminScreen());
            },
            leading: Icon(
              Icons.table_chart,
              color: Colors.black87,
            ),
            title: Text("Admin"),
          ),
          ListTile(
            onTap: () {
              Get.offAll(() => AddcafeteriaWidget());
            },
            leading: Icon(
              Icons.table_chart,
              color: Colors.black87,
            ),
            title: Text("Add Caffeteria"),
          )
        ]),
      ),
      body: AddMangerWidget(),
    );
  }
}
