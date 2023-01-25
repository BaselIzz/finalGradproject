import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/order.dart';
import 'package:gradutionfinalv/model/order_item.dart';

class FinishedOrderWidget extends StatelessWidget {
  orderModel order;
  FinishedOrderWidget(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("OrderedBY"),
            ),
            DataColumn(
              label: Text("Products"),
            ),
            DataColumn(
              label: Text("TotalPrice "),
            ),
            DataColumn(
              label: Text(""),
            ),
          ],
          rows: [
            DataRow(
                color: MaterialStateColor.resolveWith((states) {
                  {
                    if (order.payment) {
                      return Colors.green;
                    } else {
                      return Colors.red;
                    }
                  }
                }),
                cells: [
                  DataCell(Text(getOrderedBy(order.useremail))),
                  DataCell(Text(getProducts(order.order))),
                  DataCell(Text(order.totalprice)),
                  DataCell(IconButton(
                    icon: Icon(Icons.done, size: 20),
                    onPressed: () =>
                        orderController.updateSarved(order.orderid),
                  ))
                ])
          ],
        ),
      ),
    );
  }

  String getOrderedBy(String useremail) {
    return useremail.substring(0, 7);
  }

  String getProducts(List<OrderItemModel> order) {
    String items = "";
    for (var o in order) {
      items += "${o.name},";
    }
    return items;
  }
}
