import 'package:flutter/material.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';
import 'package:gradutionfinalv/widget/dark_overlay.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          top: 0.0,
          child: Image.asset(
            "asset/images/boiled_eggs.png",
            height: heightOfScreen,
            width: widthOfScreen,
            fit: BoxFit.cover,
          ),
        ),
        DarkOverLay(),
        Positioned(
            top: 300,
            left: 0,
            right: 0,
            bottom: 200,
            child: Container(
              margin: EdgeInsets.all(40),
              padding: EdgeInsets.all(40),
              width: 20,
              height: 20,
              child: Column(
                children: const [
                  CustomText(
                    text: "Caffeteria Mangment",
                    size: 20,
                    color: Colors.white,
                    weight: FontWeight.w900,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    color: Colors.green,
                  ),
                ],
              ),
            )),
      ],
    ));
  }
}
