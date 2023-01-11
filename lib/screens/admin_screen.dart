import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/addmanger_Screen.dart';
import 'package:gradutionfinalv/screens/vendor_screen.dart';
import 'package:gradutionfinalv/widget/addCaffeteriawidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../constants/controllers.dart';
import '../widget/caffeteriashow.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Caffetria",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Obx(() => UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                accountName: Text(userController.adminmodel.value.name ?? ""),
                accountEmail:
                    Text(userController.adminmodel.value.email ?? ""))),
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
                Get.off(() => AddcafeteriaWidget());
              },
              leading: const Icon(
                Icons.add,
                color: Colors.black87,
              ),
              title: const Text("Caffeteria"),
            ),
            // ListTile(
            //   onTap: () {
            //     Get.to(VendorScreen());
            //   },
            //   leading: Icon(
            //     Icons.add,
            //     color: Colors.black87,
            //   ),
            //   title: Text("Vendor"),
            // ),
            ListTile(
              onTap: () {
                Get.offAll(() => const AddMangerScreen());
              },
              leading: Icon(
                Icons.add,
                color: Colors.black87,
              ),
              title: Text("Add manger"),
            )
          ],
        ),
      ),
      body: const CaffeteiaShow(),
    );
  }
}
