import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradutionfinalv/screens/verifed_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../values/values.dart';
import '../widget/dark_overlay.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? resposeResult = "";
  bool isPasswordVisible = true;
  String? password = "";
  String? email = "";
  String? phone = "";
  String? username = "";
  String? name = "";
  String? verifcationCode = "";
  final formKey = GlobalKey<FormState>();
  final items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String? selection;
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
                    height: 16,
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
              formKey.currentState!.save();

              verifcationCode = getRandString(6);
              verifcationCode = verifcationCode!.substring(1, 7);

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

              SendEmail(
                  name: name.toString(),
                  email: email.toString(),
                  subject: "VerifcationCode",
                  message: verifcationCode.toString());

              print(resposeResult?.contains("ok"));
            }
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Verifed(
                      email: email.toString(),
                    )));
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
            Navigator.of(context).pop();
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

        if (p0!.isEmpty) {
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
        if (value!.isEmpty) {
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
    return TextFormField(
      autofillHints: [AutofillHints.name],
      onSaved: (value) => setState(() => name = value),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your Name';
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
        hintText: "Name",
        hintStyle: Styles.normalTextStyle,
        filled: true,
        fillColor: AppColors.fillColor,
      ),
      obscureText: false,
    );
  }

  Widget _buildPassowrd() {
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

  Widget _buildemail() {
    return TextFormField(
      autofillHints: [AutofillHints.email],
      onSaved: (value) => setState(() => email = value),
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
        key: formKey,
        child: Column(children: <Widget>[
          _buildDropdownlist(),
          SizedBox(
            height: 20,
          ),
          //_buildUsername(),
          //  SizedBox(
          //  height: 16,
          // ),
          _buildName(),
          SizedBox(
            height: 16,
          ),
          _buildPhonenumber(),
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

  Future<String> createrCustomer(
      {required String username,
      required String major,
      required String password,
      required String email,
      required String verifcationCode,
      required String phonenumber,
      required String name}) async {
    var url = Uri.parse('http://192.168.0.189:8080/api/save/customer');
    print("object----asdas--------------------");
    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, String>{
          "username": username,
          "password": password,
          "verifcationCode": verifcationCode,
          "email": email,
          "phoneNumber": phonenumber,
          "name": name,
          "major": major,
        }));

    print(
        "object+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

    if (response.body.toString() == "ok") {
      final message = 'Successfull';
      final snackBar = SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final message = 'this email is already registert';
      final snackBar = SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response.body.toString();
  }

  Future SendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_zez769j';
    final templateid = 'template_fti765m';
    final userId = 'VVeXoWCl-kuUPi7gn';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateid,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
      }),
    );
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
