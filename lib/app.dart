import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      home: Scaffold(body: SplashScreen()),
    );
  }
}
