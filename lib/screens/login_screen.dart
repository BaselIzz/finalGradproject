import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widget/dark_overlay.dart';
import 'register_screen.dart';
import 'main_screen.dart';

import '../values/values.dart';
import '../widget/custom_page_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  String? password = "";
  String? Email = "";

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
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
              child: ListView(
                children: <Widget>[
                  _buildHeader(),
                  SizedBox(height: 200),
                  buildForm(context),
                  SizedBox(
                    height: 36,
                  ),
                ],
              ))
        ],
      )),
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 60),
        child: Text(
          StringConst.Login_screen,
          textAlign: TextAlign.center,
          style: Styles.titleTextStyleWithSecondaryTextColor,
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _buildemail(),
              SizedBox(height: 16),
              _buildpassowrd(),
              _buildForgetbutton(),
              SizedBox(
                height: 36,
              ),
              _buildFooter(),
            ],
          )),
    );
  }

  Widget _buildemail() {
    return TextFormField(
      onSaved: (value) => setState(() => Email = value),
      validator: (value) {
        const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final regExp = RegExp(pattern);

        if (value!.isEmpty) {
          return 'Enter your university email';
        } else if (!regExp.hasMatch(value)) {
          return 'Enter a valid university email';
        }
        return null;
      },
      style: Styles.normalTextStyle,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.greyShade1,
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.greyShade1,
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.greyShade1,
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 22,
        ),
        hintText: "Email",
        hintStyle: Styles.normalTextStyle,
        filled: true,
        fillColor: AppColors.fillColor,
      ),
      obscureText: false,
    );
  }

  Widget _buildpassowrd() {
    return TextFormField(
      onSaved: (newValue) => setState(() => password = newValue),
      validator: (newvalue) {
        if (newvalue!.length < 7) {
          return "Password must be at least 7 characters long";
        }
        return null;
      },
      style: Styles.normalTextStyle,
      maxLines: 1,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: !isPasswordVisible
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.greyShade1,
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.greyShade1,
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.greyShade1,
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 22,
        ),
        hintText: "Password",
        hintStyle: Styles.normalTextStyle,
        filled: true,
        fillColor: AppColors.fillColor,
      ),
      obscureText: isPasswordVisible,
    );
  }

  Widget _buildForgetbutton() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(top: Sizes.MARGIN_16),
          child: Text(
            StringConst.FORGOT_PASSWORD_QUESTION,
            textAlign: TextAlign.right,
            style: Styles.customNormalTextStyle(),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainScreen()));

            // final isValid = formKey.currentState?.validate();
            // if (isValid == true) {
            //   formKey.currentState!.save();
            //   final message = '\nPassword: $password\nEmail: $Email';
            //   final snackBar = SnackBar(
            //     content: Text(
            //       message,
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //     backgroundColor: Colors.green,
            //   );
            //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // }
          }),
          child: Container(
            width: 300,
            height: 60,
            decoration: Decorations.primaryButtonDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: Styles.normalTextStyle,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 60.0),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: Container(
            width: 175,
            height: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringConst.CREATE_NEW_ACCOUNT,
                  textAlign: TextAlign.center,
                  style: Styles.customNormalTextStyle(),
                ),
                Spacer(),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  decoration: Decorations.horizontalBarDecoration,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
