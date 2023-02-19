import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/constants/firebase.dart';
import 'package:gradutionfinalv/model/admin.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/screens/admin_screen.dart';
import 'package:gradutionfinalv/widget/custom_btn.dart';
import 'package:gradutionfinalv/widget/custom_text_from_field.dart';
import 'package:gradutionfinalv/widget/dark_overlay.dart';
import 'package:gradutionfinalv/widget/orderWidgetnew.dart';
import 'package:http/http.dart' as http;

import '../screens/addmanger_Screen.dart';
import 'custom_text.dart';

class AddProductWidget extends StatefulWidget {
  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  PlatformFile pickedFile;
  UploadTask uploadTask;
  String donloadUrl;
  final formkey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final productNameConntroller = TextEditingController();
  final productTimeController = TextEditingController();
  final productDescriptionConntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Stack(children: <Widget>[
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
          top: 0,
          left: 0,
          right: 0,
          bottom: 36,
          child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CustomText(
                      text: caffetriaController.getCaffeterianame(
                          userController.mangerModel.value.cafeteriaid),
                      color: Colors.blue,
                      size: 24,
                      weight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () {
                      selectFile();
                    },
                    text: "Select",
                  ),
                  if (pickedFile != null)
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(15),
                        child: Image.file(
                          File(pickedFile.path),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () {
                      uploadFile();
                    },
                    text: "upload",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: CustomText(
                      color: Colors.white,
                      text: "Product Name",
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: CustomTextFormField(
                      icon: const Icon(Icons.table_chart),
                      hasPrefixIcon: true,
                      validator: (p0) {
                        if (p0.isEmpty) {
                          return "must be not empty";
                        } else {
                          return null;
                        }
                      },
                      controller: productNameConntroller,
                      hintText: "Product Name",
                      borderColor: Colors.green,
                      fillColor: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: CustomText(
                      color: Colors.white,
                      text: "Price",
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: CustomTextFormField(
                      keybordtype: const TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                      icon: const Icon(Icons.table_chart),
                      hasPrefixIcon: true,
                      validator: (p0) {
                        const regx = r"^(-?)(0|([1-9][0-9]*))(\\.[0-9]+)?$";
                        final regExp = RegExp(regx);
                        if (p0.isEmpty) {
                          return "must be not empty";
                        } else if (regExp.hasMatch(p0)) {
                          return "the value must be double";
                        } else {
                          return null;
                        }
                      },
                      controller: priceController,
                      hintText: "Product Price ",
                      borderColor: Colors.green,
                      fillColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CustomText(
                      color: Colors.white,
                      text: "Time",
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: CustomTextFormField(
                      icon: const Icon(Icons.table_chart),
                      hasPrefixIcon: true,
                      keybordtype: const TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      validator: (p0) {
                        const regx = r"/^\d+$/";
                        final regExp = RegExp(regx);
                        if (p0.isEmpty) {
                          return "must be not empty";
                        } else if (regExp.hasMatch(p0)) {
                          return "the value must be double";
                        } else {
                          return null;
                        }
                      },
                      controller: productTimeController,
                      hintText: "Product Time",
                      borderColor: Colors.green,
                      fillColor: Colors.black,
                    ),
                  ),
                  const Center(
                    child: CustomText(
                      color: Colors.white,
                      text: "Discription",
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: CustomTextFormField(
                      icon: const Icon(Icons.table_chart),
                      hasPrefixIcon: true,
                      validator: (p0) {
                        if (p0.isEmpty) {
                          return "must be not empty";
                        } else {
                          return null;
                        }
                      },
                      controller: productDescriptionConntroller,
                      hintText: "Product Description",
                      borderColor: Colors.green,
                      fillColor: Colors.black,
                      maxLines: 5,
                    ),
                  ),
                  CustomButton(
                      text: "Add Product",
                      onTap: () {
                        final isValid = formkey.currentState.validate();
                        if (isValid) {
                          ProductModel product = ProductModel(
                              ProductID: "",
                              ProductName: productNameConntroller.text,
                              ProductPhoto: donloadUrl,
                              ProductPrice: priceController.text,
                              caffeteriaid:
                                  userController.mangerModel.value.cafeteriaid,
                              is_Exist: true,
                              ProductTime: productTimeController.text,
                              description: productDescriptionConntroller.text);
                          productsController.addproduct(product);
                          String name = caffetriaController
                              .getCaffeterianame(product.caffeteriaid);
                          sendMessageForAllusers(
                              "$name Caffeteria have a new Meal wit Name : ${product.ProductName}",
                              "New Meal!!!!!!!!");
                          productNameConntroller.clear();
                          priceController.clear();
                          productTimeController.clear();
                          productDescriptionConntroller.clear();
                        }
                      }),
                ]),
              )))
    ]);
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    if (pickedFile.path.isNotEmpty) {
      final path = "products/${pickedFile.name}";
      final file = File(pickedFile.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      donloadUrl = await snapshot.ref.getDownloadURL();
      print(donloadUrl);
      Get.snackbar(
          "The photo Upladed Scessfully", "The photo Upladed Scessfully");
    } else {
      Get.snackbar("You Cant upload No photo", "Select Photofirst");
    }
  }

  void sendMessageForAllusers(String body, String title) async {
    var serverToken =
        "AAAAVLVNjEk:APA91bGVcOv-6S0OwzCBKD4eG20OD3W8zOXxTfCSeVIBtl6Sce7Pe4OcNkSV3jxhQ9XDB6Ix43jGdfrtJ3yRZUi1yppHAikqs_FkKGb1nJZebEp-na50STJf2I04XGbEpDdR2tPRnRjM";
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': "done",
            },
            "to": "/topics/birzeit"
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }
}
