import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/controllers/caffetria_controller.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/screens/caffeteria_item_screen.dart';
import 'package:gradutionfinalv/widget/caffeteriaitem.dart';
import 'package:http/http.dart';

import '../constants/controllers.dart';
import '../values/values.dart';
import '../widget/foody_bite_card.dart';

class CaffeteriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(child: Text("CaffeteriaScreen"))),
        body: CaffeteriaItemScreen());
  }
}
