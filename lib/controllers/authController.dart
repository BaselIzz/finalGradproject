
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../constants/app_constatns.dart';
// // import 'package:untitled/constants/firebase.dart';
// // import 'package:untitled/models/user.dart';
// // import 'package:untitled/screens/authentication/auth.dart';
// // import 'package:untitled/screens/home/home.dart';
// // import 'package:untitled/utils/helpers/showLoading.dart';

// class UserController extends GetxController {
//   static UserController instance = Get.find();
//   Rx<User> firebaseUser;
//   RxBool isLoggedIn = false.obs;
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   String usersCollection = "users";
//   Rx<UserModel> userModel = UserModel().obs;
//   Rx<AdminModel> Adminmodel = AdminModel().obs;

//   @override
//   void onReady() {
//     super.onReady();

//     firebaseUser = Rx<User>(auth.currentUser);
//     firebaseUser.bindStream(auth.userChanges());

//     ever(firebaseUser, _setInitialScreen);
//     // ever(firebaseUser, _setInitialScreen);
//   }

//   _setInitialScreen(User user) async {
//     if (user == null) {
//       Get.offAll(() => AuthenticationScreen());
//     } else {
//       insitializeusermodel(auth.currentUser.uid);
//     }
//   }

//   void signIn() async {
//     try {
//       showLoading();
//       await auth
//           .signInWithEmailAndPassword(
//               email: email.text.trim(), password: password.text.trim())
//           .then((result) {
//         String _userId = result.user.uid;

//         insitializeusermodel(_userId);
//         _clearControllers();
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//       Get.snackbar("Sign In Failed", "Try again");
//       dismissLoadingWidget();
//     }
//   }

//   void signUp() async {
//     showLoading();
//     try {
//       await auth
//           .createUserWithEmailAndPassword(
//               email: email.text.trim(), password: password.text.trim())
//           .then((result) {
//         String _userId = result.user.uid;
//         _addUserToFirestore(_userId);
//         _clearControllers();
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//       Get.snackbar("Sign In Failed", "Try again");
//       dismissLoadingWidget();
//     }
//   }

//   void signOut() async {
//     auth.signOut();
//   }

//   _addUserToFirestore(String userId) {
//     firebaseFirestore.collection(usersCollection).doc(userId).set({
//       "name": name.text.trim(),
//       "id": userId,
//       "email": email.text.trim(),
//       "cart": [],
//       "role": "user"
//     });
//   }

//   _clearControllers() {
//     name.clear();
//     email.clear();
//     password.clear();
//   }

//   updateUserData(Map<String, dynamic> data) {
//     logger.i("UPDATED");
//     firebaseFirestore
//         .collection(usersCollection)
//         .doc(firebaseUser.value.uid)
//         .update(data);
//   }

//   insitializeusermodel(String userid) async {
//     await firebaseFirestore
//         .collection(usersCollection)
//         .doc(userid)
//         .get()
//         .then((value) async {
//       if (value.get("role") == "user") {
//         userModel.value = await firebaseFirestore
//             .collection(usersCollection)
//             .doc(userid)
//             .get()
//             .then((doc) => UserModel.fromSnapshot(doc));
//         userModel.bindStream(listenToUser());
//         Get.offAll(() => HomeScreen());
//       } else {
//         Adminmodel.value = await firebaseFirestore
//             .collection(usersCollection)
//             .doc(userid)
//             .get()
//             .then((value) => AdminModel.fromSnapshot(value));

//         Get.offAll(() => Adminpage());
//       }
//     });
//   }

//   Stream<UserModel> listenToUser() => firebaseFirestore
//       .collection(usersCollection)
//       .doc(firebaseUser.value.uid)
//       .snapshots()
//       .map((snapshot) => UserModel.fromSnapshot(snapshot));
// }
