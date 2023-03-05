import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/widget/custom_text_from_field.dart';
import 'package:gradutionfinalv/widget/dark_overlay.dart';

import '../values/values.dart';

class AddMangerWidget extends StatefulWidget {
  final List<String> items = ["1", 'Item 1', 'Item 2', 'Item 3', 'Item 4'];

  AddMangerWidget({Key key}) : super(key: key);

  @override
  State<AddMangerWidget> createState() => _AddMangerWidgetState();
}

class _AddMangerWidgetState extends State<AddMangerWidget> {
  bool isPasswordVisible = true;

  String selection;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    selection = widget.items.first.toString();
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
        child: ListView(children: [
          SizedBox(
            height: 16,
          ),
          _buildForm(),
        ]),
      )
    ]);
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(children: <Widget>[
          _buildDropdownlist(),
          SizedBox(
            height: 20,
          ),
          // SizedBox(
          //   height: 20,
          // ),
          //_buildUsername(),
          //  SizedBox(
          //  height: 16,
          // ),
          _buildName(),
          // SizedBox(
          //   height: 16,
          // ),
          // _buildPhonenumber(),
          SizedBox(
            height: 16,
          ),
          _buildemail(),
          SizedBox(
            height: 16,
          ),
          _buildPassowrd(),
          _buildFooter()
        ]),
      ),
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
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+com";
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

  Widget _buildDropdownlist() {
    return Obx(() => DropdownButtonFormField<String>(
          dropdownColor: AppColors.greyShade1,
          onSaved: (newValue) => setState(
            () => selection = newValue,
          ),
          items: caffetriaController.cafeterias
                  .where((element) => element.hasuser == false)
                  .map((caffeteria) {
                return DropdownMenuItem(
                  value: caffeteria.cafeteriaId,
                  child: Text(caffeteria.cafeteriaName),
                );
              }).toList() ??
              [],
          borderRadius: BorderRadius.circular(10),
          menuMaxHeight: 100.2,
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              decorationColor: Colors.blue,
              overflow: TextOverflow.fade),
          focusColor: Colors.black,
          value: caffetriaController.cafeterias
                  .where((element) => element.hasuser == false)
                  .map((caffeteria) {
                    return caffeteria.cafeteriaId.toString();
                  })
                  .toList()
                  .first ??
              "empty",
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down_circle),
          onChanged: (value) {
            setState(() {
              this.selection = value;
            });
          },
        ));
  }

  Widget _buildFooter() {
    return Column(children: <Widget>[
      InkWell(
        onTap: (() {
          final isValid = formKey.currentState.validate();
          if (isValid == true) {
            formKey.currentState.save();
            userController.signOut();
            userController.createManger(selection.toString());
            caffetriaController.changehasuser(selection.toString().trim());
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
                "Create Manger ",
                textAlign: TextAlign.center,
                style: Styles.normalTextStyle,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
