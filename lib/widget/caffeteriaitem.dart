import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/controllers/caffetria_controller.dart';
import 'package:gradutionfinalv/widget/foody_bite_card.dart';

import '../model/cafeteria.dart';

class CaffeteriaItems extends StatelessWidget {
  const CaffeteriaItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
          scrollDirection: Axis.horizontal,
          children:
              caffetriaController.cafeterias.map((CafeteriaModel caffeteria) {
            return FoodyBiteCard(
              caffeteria: caffeteria,
              imagePath: caffeteria.Caf_img,
            );
          }).toList()),
    );
  }
}
