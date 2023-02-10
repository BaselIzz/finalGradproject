import 'dart:async';

import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/constants/firebase.dart';

import '../widget/dark_overlay.dart';
import 'verifed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'register_screen.dart';
import 'main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../values/values.dart';
import '../widget/custom_page_route.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verifed extends StatefulWidget {
  const Verifed({
    Key key,
  }) : super(key: key);

  @override
  State<Verifed> createState() => _VerifedState();
}

class _VerifedState extends State<Verifed> {
  bool isEmailverifyed = false;
  Timer timer;
  @override
  void initState() {
    isEmailverifyed = auth.currentUser.emailVerified;
    if (!isEmailverifyed) {
      auth.currentUser.sendEmailVerification();
      timer =
          Timer.periodic(Duration(seconds: 30), (_) => checkEmailVerifyed());
      super.initState();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future checkEmailVerifyed() async {
    await auth.currentUser.reload();
    setState(() {
      isEmailverifyed = auth.currentUser.emailVerified;
    });
    if (isEmailverifyed) timer.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailverifyed
      ? MainScreen()
      : Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Verify scrren",
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.black,
          ),
          drawer: Drawer(
              child: ListView(children: [
            Obx(() => UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(userController.userModel.value.name ?? ""),
                accountEmail:
                    Text(userController.userModel.value.email ?? ""))),
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
          ])),
          body: Padding(
            padding: EdgeInsets.all(16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "A verifaction have been sent to the Email ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ]),
          ));
}
