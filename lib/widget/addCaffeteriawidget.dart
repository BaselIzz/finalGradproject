import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/admin.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/screens/admin_screen.dart';
import 'package:gradutionfinalv/widget/custom_btn.dart';
import 'package:gradutionfinalv/widget/custom_text_from_field.dart';
import 'package:gradutionfinalv/widget/dark_overlay.dart';
import 'package:gradutionfinalv/widget/orderWidgetnew.dart';

import '../screens/addmanger_Screen.dart';
import 'custom_text.dart';

class AddcafeteriaWidget extends StatefulWidget {
  @override
  State<AddcafeteriaWidget> createState() => _AddcafeteriaWidgetState();
}

class _AddcafeteriaWidgetState extends State<AddcafeteriaWidget> {
  PlatformFile pickedFile;
  UploadTask uploadTask;
  String donloadUrl;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final caffeterianamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            //this is for basel izz
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Cafeteria",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  Obx(() => UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.black),
                      accountName:
                          Text(userController.adminmodel.value.name ?? ""),
                      accountEmail:
                          Text(userController.adminmodel.value.email ?? ""))),
                  ListTile(
                    onTap: () {
                      print("__________________________________Signout");

                      userController.signOut();
                    },
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.black87,
                    ),
                    title: Text("Log out"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(const AdminScreen());
                    },
                    leading: Icon(
                      Icons.table_chart,
                      color: Colors.black87,
                    ),
                    title: Text("Admin"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.offAll(AddMangerScreen());
                    },
                    leading: Icon(
                      Icons.add,
                      color: Colors.black87,
                    ),
                    title: Text("Add manger"),
                  )
                ],
              ),
            ),
            body: Stack(children: <Widget>[
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
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListView(children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 5,
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
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            onTap: () {
                              uploadFile();
                            },
                            text: "upload",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CustomText(
                              color: Colors.white,
                              text: "Caffeteria Name",
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
                              controller: caffeterianamecontroller,
                              hintText: "Caffeteria Name",
                              borderColor: Colors.green,
                              fillColor: Colors.black,
                            ),
                          ),
                          CustomButton(
                              text: "Add Caffeteria",
                              onTap: () {
                                final isValid = formkey.currentState.validate();
                                if (isValid) {
                                  CafeteriaModel caf = CafeteriaModel(
                                      Caf_img: donloadUrl,
                                      cafeteriaId: "",
                                      cafeteriaName:
                                          caffeterianamecontroller.text,
                                      email: "noBody",
                                      hasuser: false,
                                      is_Active: false);
                                  caffetriaController.addCaffeteria(caf);
                                  caffeterianamecontroller.clear();
                                  emailController.clear();
                                }
                              }),
                        ]),
                      )))
            ])));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    if (pickedFile.path.isNotEmpty) {
      final path = "Caffeteria/${pickedFile.name}";
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
}
