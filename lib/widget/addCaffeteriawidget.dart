// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:gradutionfinalv/constants/controllers.dart';
// import 'package:gradutionfinalv/model/cafeteria.dart';
// import 'package:gradutionfinalv/widget/custom_btn.dart';
// import 'package:gradutionfinalv/widget/custom_text_from_field.dart';

// import 'custom_text.dart';

// class AddcafeteriaWidget extends StatefulWidget {
//   @override
//   State<AddcafeteriaWidget> createState() => _AddcafeteriaWidgetState();
// }

// class _AddcafeteriaWidgetState extends State<AddcafeteriaWidget> {
//   PlatformFile pickedFile;
//   UploadTask uploadTask;
//   String donloadUrl;
//   final formkey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final caffeterianamecontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Form(
//         key: formkey,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         child: ListView(children: [
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: CustomText(
//               text: "Add Cafeteria",
//               size: 24,
//               weight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           CustomButton(
//             onTap: () {
//               selectFile();
//             },
//             text: "Select",
//           ),
//           if (pickedFile != null)
//             Expanded(
//               child: Container(
//                 // width: 300,
//                 //height: 300,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Image.file(
//                     File(pickedFile.path),
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           SizedBox(
//             height: 20,
//           ),
//           CustomButton(
//             onTap: () {
//               uploadFile();
//             },
//             text: "upload",
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: CustomText(
//               text: "CaffeteriaName",
//               size: 20,
//               weight: FontWeight.w600,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             child: CustomTextFormField(
//               validator: (p0) {
//                 if (p0.isEmpty) {
//                   return "must be not empty";
//                 } else {
//                   return null;
//                 }
//               },
//               controller: caffeterianamecontroller,
//               hintText: "CaffeteriaName",
//               borderColor: Colors.black,
//               fillColor: Colors.black,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: CustomText(
//               text: "emailAddress",
//               size: 20,
//               weight: FontWeight.w600,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             child: CustomTextFormField(
//               validator: (p0) {
//                 if (p0.isEmpty) {
//                   return "must not be empty";
//                 } else {
//                   return null;
//                 }
//               },
//               controller: emailController,
//               hintText: "email",
//               borderColor: Colors.black,
//               fillColor: Colors.black,
//             ),
//           ),
//           CustomButton(
//               text: "AddCaffeteria",
//               onTap: () {
//                 final isValid = formkey.currentState.validate();
//                 if (isValid) {
//                   CafeteriaModel caf = CafeteriaModel(
//                       cafeteriaId: "",
//                       cafeteriaName: caffeterianamecontroller.text,
//                       email: emailController.text,
//                       hasuser: false,
//                       is_Active: false);
//                   caffetriaController.addCaffeteria(caf);
//                   caffeterianamecontroller.clear();
//                   emailController.clear();
//                 }
//               }),
//         ]),
//       )
//     ]);
//   }

//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.image);
//     setState(() {
//       pickedFile = result.files.first;
//     });
//   }

//   Future uploadFile() async {
//     final path = "products/${pickedFile.name}";
//     final file = File(pickedFile.path);
//     final ref = FirebaseStorage.instance.ref().child(path);
//     uploadTask = ref.putFile(file);
//     final snapshot = await uploadTask.whenComplete(() {});
//     donloadUrl = await snapshot.ref.getDownloadURL();
//     print(donloadUrl);
//     Get.snackbar(
//         "The photo Upladed Scessfully", "The photo Upladed Scessfully");
//   }
// }
