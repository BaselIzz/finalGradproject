import 'package:flutter/material.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/product.dart';

class ShowProductWidget extends StatelessWidget {
  ProductModel product;
  ShowProductWidget(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text("Product iD"),
          ),
          DataColumn(
            label: Text("Product Name "),
          ),
          DataColumn(
            label: Text("Product photo "),
          ),
          DataColumn(
            label: Text("Product Status "),
          ),
          DataColumn(
            label: Text("Product Price "),
          ),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(product.ProductID)),
            DataCell(Text(product.ProductName)),
            DataCell(Image.network(
              product.ProductPhoto,
              width: 50,
            )),
            DataCell(IconButton(
              icon: product.is_Exist
                  ? const Icon(Icons.done)
                  : const Icon(Icons.clear),
              onPressed: () => productsController.updateStatus(
                  product.ProductID, product.is_Exist),
            )),
            DataCell(Text(product.ProductPrice))
          ])
        ],
      ),
    );
  }
}
