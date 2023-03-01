import 'dart:async';

import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/constants/firebase.dart';

import 'package:flutter/material.dart';

import 'main_screen.dart';

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
          Timer.periodic(Duration(seconds: 20), (_) => checkEmailVerifyed());
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
