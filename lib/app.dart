import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loginscreen',
      home: Scaffold(body: LoginScreen()),
    );
  }
}
