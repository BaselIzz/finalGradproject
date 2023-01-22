// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:gradutionfinalv/constants/controllers.dart';
// import 'package:gradutionfinalv/model/product.dart';
// import 'package:string_similarity/string_similarity.dart';

// class RecommendationController extends GetxController {
//   static RecommendationController instace = Get.find();
//   RxMap<ProductModel, List<ProductModel>> Reclist =
//       RxMap<ProductModel, List<ProductModel>>();
//   @override
//   void onReady() async {
//     // TODO: implement onReady
//     super.onReady();
//   }

  // void getrecomander() {
  //   List<List<double>> descriptionMatrix = [];
  //   for (var i = 0; i < productsController.products.length; i++) {
  //     descriptionMatrix.add([]);
  //     for (var j = 0; j < productsController.products.length; j++) {
  //       var similarity = StringSimilarity.compareTwoStrings(
  //           productsController.products[i].description,
  //           productsController.products[j].description);
  //       descriptionMatrix[i].add(similarity);
  //     }
  //   }
  //   List<ProductModel> data = [];
  //   // Print the similarity scores for the first meal
  //   for (var i = 0; i < productsController.products.length; i++) {
  //     for (var j = 0; j < productsController.products.length; j++) {
  //       if (descriptionMatrix[i][j] >= 0.5) {
  //         data.add(productsController.products[j]);
  //       }
  //     }
  //     Reclist.putIfAbsent(productsController.products[i], () => data);
  //   }
  //      }
// 