import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/screens/login_screen.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

import '../constants/controllers.dart';
import '../values/values.dart';
import '../widget/custom_text_from_field.dart';
import '../widget/dark_overlay.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
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
                  fit: BoxFit.cover,
                  height: heightOfScreen,
                  width: widthOfScreen,
                ),
              ),
              DarkOverLay(),
              Positioned(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_24),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        _buildHeader(context),
                        Container(
                          margin: EdgeInsets.only(top: Sizes.MARGIN_60),
                          child: Text(
                            StringConst.RESET_PASSWORD_DESCRIPTION,
                            textAlign: TextAlign.center,
                            style: Styles.customMediumTextStyle(),
                          ),
                        ),
                        const SizedBox(height: Sizes.HEIGHT_60),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Sizes.MARGIN_16),
                          child: CustomTextFormField(
                            controller: userController.email,
                            validator: (p0) {
                              if (p0.isEmpty) {
                                return "The Email Text Must not Be empty";
                              }
                              return null;
                            },
                            hasPrefixIcon: true,
                            icon: Icon(Icons.email),
                            hintText: StringConst.HINT_TEXT_EMAIL,
                          ),
                        ),
                        SizedBox(height: Sizes.HEIGHT_180),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: Sizes.MARGIN_16,
                          ),
                          child: InkWell(
                            onTap: (() {
                              final isValid = formKey.currentState.validate();
                              if (isValid == true) {
                                formKey.currentState.save();
                                userController.forgetpassword();
                              }
                              Get.off(() => LoginScreen());
                            }),
                            child: Container(
                              width: 300,
                              height: 60,
                              decoration: Decorations.primaryButtonDecoration,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "SEND",
                                    textAlign: TextAlign.center,
                                    style: Styles.normalTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 60),
        child: Text(
          StringConst.FORGOT_PASSWORD,
          textAlign: TextAlign.center,
          style: Styles.titleTextStyleWithSecondaryTextColor,
        ),
      ),
    );
  }
}
