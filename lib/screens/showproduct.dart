import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/widget/showProductswidget.dart';

class ShowProductsTable extends StatelessWidget {
  const ShowProductsTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            children: productsController.products
                .where((p0) =>
                    p0.caffeteriaid ==
                    userController.vendormodel.value.caffeteriaid)
                .map((ProductModel product) {
              return ShowProductWidget(product);
            }).toList(),
          )),
    );
  }
}
