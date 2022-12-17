import '../widget/dark_overlay.dart';
import 'verifed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'register_screen.dart';
import 'main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../values/values.dart';
import '../widget/custom_page_route.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verifed extends StatefulWidget {
  final String email;

  const Verifed({
    Key key,
    this.email,
  }) : super(key: key);

  @override
  State<Verifed> createState() => _VerifedState();
}

class _VerifedState extends State<Verifed> {
  @override
  final formKey = GlobalKey<FormState>();
  String verifcationCode = "";
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
        body: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
          ),
          child: Stack(
            children: [
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
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        _buildAppBar(context),
                        Container(
                          margin: EdgeInsets.only(top: Sizes.MARGIN_60),
                          child: Text(
                            "Enter your Verifcation code that sent to your email",
                            textAlign: TextAlign.center,
                            style: Styles.customMediumTextStyle(),
                          ),
                        ),
                        SizedBox(height: Sizes.HEIGHT_20),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Sizes.MARGIN_16),
                          child: _buildpin(),
                        ),
                        SizedBox(height: Sizes.HEIGHT_10),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: Sizes.MARGIN_16,
                          ),
                          child: _buildButton(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.MARGIN_12,
              right: Sizes.MARGIN_12,
              top: Sizes.MARGIN_4,
              bottom: Sizes.MARGIN_4,
            ),
          ),
        ),
        Spacer(),
        Text(
          "Verification",
          style: Styles.customMediumTextStyle(),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildpin() {
    return PinCodeTextField(
        textStyle: TextStyle(color: Colors.blue),
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "please enter the verifcation code ";
          } else if (value.length < 6) {
            return "The value sholud be complete";
          }
          return null;
        },
        beforeTextPaste: (text) {
          debugPrint("Allowing to paste $text");
          return true;
        },
        onSaved: (newValue) => verifcationCode = newValue,
        appContext: context,
        length: 6,
        onChanged: (value) => print(value));
  }

  Widget _buildButton() {
    return InkWell(
      onTap: (() {
        print(widget.email);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const MainScreen()));

        final isValid = formKey.currentState?.validate();
        if (isValid == true) {
          formKey.currentState.save();
          final message =
              'Verifcation code: $verifcationCode\n Email: ${widget.email}';

          final snackBar = SnackBar(
            content: Text(
              message,
              style: const TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              "Submit",
              textAlign: TextAlign.center,
              style: Styles.normalTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  // Future<String> sendVerifcationCode(
  //     { String username,
  //      String major,
  //      String password,
  //      String email,
  //      String verifcationCode,
  //      String phonenumber,
  //      String name}) async {
  //   var url = Uri.parse(
  //       'http://192.168.0.189:8080/api/check/smsCode/{{$verifcationCode}}');
  //   print("object----asdas--------------------");
  //   http.Response response = await http.post(url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode(<String, String>{
  //         "username": username,
  //         "password": password,
  //         "verifcationCode": verifcationCode,
  //         "email": email,
  //         "phoneNumber": phonenumber,
  //         "name": name,
  //         "major": major,
  //       }));

  //   return "meso";
  // }
}
