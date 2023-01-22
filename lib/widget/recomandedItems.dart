import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/controllers/caffetria_controller.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/model/user.dart';
import 'package:gradutionfinalv/widget/foody_bite_card.dart';
import 'package:gradutionfinalv/widget/recomandedByCar.dart';

import '../model/cafeteria.dart';

class RecomandedItems extends StatelessWidget {
  const RecomandedItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
        scrollDirection: Axis.horizontal,
        children: userController.userModel.value.historyList
                .map((ProductModel productModel) {
              return RecomandedByCar(
                productModel: productModel,
                imagePath: productModel.ProductPhoto,
              );
            }).toList() ??
            Container()));
  }
}
