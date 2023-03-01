import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/manger.dart';
import 'package:gradutionfinalv/model/vendor.dart';
import 'package:gradutionfinalv/screens/login_screen.dart';
import 'package:gradutionfinalv/screens/main_screen.dart';
import 'package:gradutionfinalv/screens/manger_screen.dart';
import 'package:gradutionfinalv/screens/vendor_screen.dart';
import 'package:gradutionfinalv/screens/verifed_screen.dart';

import '../constants/app_constatns.dart';
import '../constants/firebase.dart';
import '../model/admin.dart';
import '../model/user.dart';
import '../screens/admin_screen.dart';
import '../screens/home_screen.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;
  Rx<AdminModel> adminmodel = AdminModel().obs;
  Rx<VendorModel> vendormodel = VendorModel().obs;
  Rx<MangerModel> mangerModel = MangerModel().obs;
  String useremail, userpassword;

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) async {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      insitializeusermodel(auth.currentUser.uid);
    }
  }

  void signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        useremail = email.text;
        userpassword = password.text;
        String _userId = result.user.uid;
        getToken(_userId);

        insitializeusermodel(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signInwithEmailandPassword(String useremail, String userpassword) async {
    try {
      //  showLoading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        useremail = email.text.trim();
        userpassword = password.text.trim();
        String _userId = result.user.uid;

        insitializeusermodel(_userId);
        getToken(_userId);

        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
      //  dismissLoadingWidget();
    }
  }

  void getToken(String userid) async {
    await FirebaseMessaging.instance.getToken().then((token) {
      firebaseFirestore.collection("UserTokens").doc(userid).set({
        'token': token,
      });
      logger.i({"$token": "GetToken"});
    });
  }

  void signUp() async {
    // showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user.uid;
        FirebaseMessaging.instance.subscribeToTopic('birzeit');
        _addUserToFirestore(_userId);
        _clearControllers();
        getToken(_userId);

        auth.currentUser.sendEmailVerification();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
      //  dismissLoadingWidget();
    }
  }

  void createManger(String caffeteriaid) async {
    try {
      signOut();
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        String _userid = value.user.uid;
        addMangerToFirestore(_userid, caffeteriaid);
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign up Failed", "Try again");
    }
  }

  void createVendor() async {
    try {
      signOut();
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        String _userid = value.user.uid;
        addvendorTofirebase(_userid);
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign up Failed", "Try again");
    }
  }

  addMangerToFirestore(String userId, String cafeteriaid) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.trim(),
      "cafeteriaid": cafeteriaid.toString(),
      "role": "manger"
    });
  }

  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.trim(),
      "cart": [],
      "history_list": [],
      "role": "user"
    });
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));

  insitializeusermodel(String userid) async {
    await firebaseFirestore
        .collection(usersCollection)
        .doc(userid)
        .get()
        .then((value) async {
      if (value.get("role") == "user") {
        userModel.value = await firebaseFirestore
            .collection(usersCollection)
            .doc(userid)
            .get()
            .then((doc) => UserModel.fromSnapshot(doc));
        userModel.bindStream(listenToUser());
        if (auth.currentUser.emailVerified != true) {
          Get.snackbar("Your Account is not verfy ", "Go To Your Email");

          auth.currentUser.sendEmailVerification();
          Get.offAll(() => const Verifed());
        } else {
          Get.offAll(() => MainScreen());
        }
      } else if (value.get("role") == "admin") {
        adminmodel.value = await firebaseFirestore
            .collection(usersCollection)
            .doc(userid)
            .get()
            .then((doc) => AdminModel.fromSnapshot(doc));
        Get.offAll(() => const AdminScreen());
      } else if (value.get("role") == "manger") {
        mangerModel.value = await firebaseFirestore
            .collection(usersCollection)
            .doc(userid)
            .get()
            .then((value) => MangerModel.fromSnapshot(value));
        Get.offAll(() => const MangerScreen());
      } else {
        vendormodel.value = await firebaseFirestore
            .collection(usersCollection)
            .doc(userid)
            .get()
            .then((value) => VendorModel.fromSnapshot(value));
        Get.offAll(() => const VendorScreen());
      }
    });
  }

  void forgetpassword() {
    try {
      auth.sendPasswordResetEmail(email: email.text.trim());
      Get.snackbar("The Message Have Been Sent", "Go to your Email");
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("There is a proplem", "Can send forget password");
    }
  }

  void addvendorTofirebase(String userid) {
    firebaseFirestore.collection(usersCollection).doc(userid).set({
      "name": name.text.trim(),
      "id": userid,
      "email": email.text.trim(),
      "cafeteriaid": mangerModel.value.cafeteriaid,
      "role": "vendor"
    });
  }
}
