import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/model/admin.dart';
import 'package:gradutionfinalv/screens/addmanger_Screen.dart';
import 'package:gradutionfinalv/screens/vendor_screen.dart';
import 'package:gradutionfinalv/widget/addCaffeteriawidget.dart';
import 'package:gradutionfinalv/widget/addProductwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../constants/controllers.dart';
import '../widget/caffeteriashow.dart';

class MangerScreen extends StatelessWidget {
  const MangerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            //this is for basel izz
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Add Product",
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
                    // Get.to(VendorScreen());
                  },
                  leading: Icon(
                    Icons.add,
                    color: Colors.black87,
                  ),
                  title: Text("Add Vendor"),
                ),
                ListTile(
                  onTap: () {
                    // Get.to(VendorScreen());
                  },
                  leading: Icon(
                    Icons.add,
                    color: Colors.black87,
                  ),
                  title: Text("Add Vendor"), //add product
                ),
              ],
            ),
          ),
          body: AddProductWidget(),
        ));
  }
}
