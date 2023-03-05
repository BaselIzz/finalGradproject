import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/controllers/authController.dart';
import 'package:gradutionfinalv/screens/login_screen.dart';
import 'package:gradutionfinalv/screens/verifed_screen.dart';
import 'package:gradutionfinalv/widget/custom_text_from_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../values/values.dart';
import '../widget/dark_overlay.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String resposeResult = "";
  bool isPasswordVisible = true;
  String password = "";
  String email = "";
  String phone = "";
  String username = "";
  String name = "";
  String verifcationCode = "";
  final formKey = GlobalKey<FormState>();
  final items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String selection;
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
                  SizedBox(
                    height: 200,
                  ),
                  _buildForm(),
                  SizedBox(
                    height: 16,
                  ),
                  _buildFooter(),
                ],
              ))
        ],
      )),
    );
  }

  Widget _buildDropdownlist() {
    return DropdownButton<String>(
      dropdownColor: AppColors.greyShade1,
      items: items.map(buildMenuitem).toList(),
      borderRadius: BorderRadius.circular(10),
      menuMaxHeight: 100.2,
      style: TextStyle(color: AppColors.greyShade1),
      focusColor: AppColors.greyShade1,
      value: selection,
      isExpanded: true,
      hint: Text(
        "Your Major",
        style:
            TextStyle(color: AppColors.greyShade1, fontWeight: FontWeight.w500),
      ),
      icon: const Icon(Icons.arrow_drop_down_circle),
      onChanged: (value) {
        setState(() {
          this.selection = value;
        });
      },
    );
  }

  Widget _buildFooter() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (() {
            final isValid = formKey.currentState?.validate();
            if (isValid == true) {
              formKey.currentState.save();
              userController.signUp();

              // verifcationCode = getRandString(6);
              // verifcationCode = verifcationCode!.substring(1, 7);

              // createrCustomer(
              //         username: username.toString(),
              //         major: selection.toString(),
              //         password: password.toString(),
              //         verifcationCode: verifcationCode.toString(),
              //         email: email.toString(),
              //         phonenumber: phone.toString(),
              //         name: name.toString())
              //     .then((value) {
              //   print(value);
              //   resposeResult = value;
              // });

              //   SendEmail(
              //       name: name.toString(),
              //       email: email.toString(),
              //       subject: "VerifcationCode",
              //       message: verifcationCode.toString());

              //   print(resposeResult?.contains("ok"));
            }
          }),
          child: Container(
            width: 300,
            height: 60,
            decoration: Decorations.primaryButtonDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
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
            Get.offAll(LoginScreen());
          },
          child: Container(
            width: 200,
            height: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringConst.HAVE_AN_ACCOUNT_QUESTION,
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

  Widget _buildPhonenumber() {
    return InternationalPhoneNumberInput(
      autofillHints: [AutofillHints.telephoneNumber],
      onInputChanged: (PhoneNumber number) {
        print(number);
        print(number.isoCode);
      },
      countries: ["PS", "IL"],
      formatInput: true,
      onSaved: (value) => phone = value.phoneNumber.toString(),
      validator: (p0) {
        String regxexxx = r'^(?:[+0][1-9])?[0-9]{10,12}$';
        RegExp regExp = new RegExp(regxexxx);

        if (p0.isEmpty) {
          return 'Enter your PhoneNumber';
        } else if (regExp.hasMatch(p0)) {
          return 'Enter a valid Phonenumber';
        }
        return null;
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      keyboardType: TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      inputDecoration: InputDecoration(
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
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 22,
        ),
        hintText: "PhoneNumber",
        hintStyle: Styles.normalTextStyle,
        filled: true,
        fillColor: AppColors.fillColor,
      ),
    );
  }

  Widget _buildUsername() {
    return TextFormField(
      onSaved: (value) => setState(() => username = value),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter your username';
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
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 22,
        ),
        hintText: "Username",
        hintStyle: Styles.normalTextStyle,
        filled: true,
        fillColor: AppColors.fillColor,
      ),
      obscureText: false,
    );
  }

  Widget _buildName() {
    return CustomTextFormField(
      autofillHints: [AutofillHints.name],
      // onSaved: (value) => setState(() => name = value),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter your Name';
        }
        return null;
      },
      icon: Icon(Icons.person),
      hintText: "Name",
      hasPrefixIcon: true,
      obscured: false,
      controller: userController.name,
    );
  }

  Widget _buildPassowrd() {
    return CustomTextFormField(
      autofillHints: [AutofillHints.email],
      icon: Icon(Icons.key),
      controller: userController.password,
      hasPrefixIcon: true,
      //  onSaved: (newValue) => setState(() => password = newValue),
      validator: (newvalue) {
        const pattern =
            r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!#%*?&]{8,18}$)';
        final regExp = RegExp(pattern);
        if (newvalue.isEmpty) {
          return 'please enter a password';
        } else if (!regExp.hasMatch(newvalue)) {
          return "your password mush have captal and number";
        } else {
          return null;
        }
      },
      maxLength: 18,
      hintText: "Password",
      filled: true,
      fillColor: AppColors.fillColor,

      obscured: isPasswordVisible,
    );
  }

  Widget _buildemail() {
    return CustomTextFormField(
      autofillHints: [AutofillHints.email],
      // onSaved: (value) => setState(() => email = value),
      validator: (value) {
        const pattern =
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+edu";
        final regExp = RegExp(pattern);

        if (value.isEmpty) {
          return 'Enter your university email';
        } else if (!regExp.hasMatch(value)) {
          return 'Enter a valid university email';
        }
        return null;
      },
      hintText: "Email",
      icon: Icon(Icons.email),
      hasPrefixIcon: true,
      controller: userController.email,
      obscured: false,
    );
  }

  DropdownMenuItem<String> buildMenuitem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: Sizes.MARGIN_60),
        child: Text(
          StringConst.Register_screen,
          textAlign: TextAlign.center,
          style: Styles.titleTextStyleWithSecondaryTextColor,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(children: <Widget>[
          _buildName(),
          SizedBox(
            height: 16,
          ),
          _buildemail(),
          SizedBox(
            height: 16,
          ),
          _buildPassowrd(),
        ]),
      ),
    );
  }
}
