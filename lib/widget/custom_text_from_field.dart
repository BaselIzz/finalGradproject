import 'package:flutter/material.dart';

import '../values/values.dart';

class CustomTextFormField extends StatelessWidget {
  final TextStyle textFormFieldStyle;
  final TextStyle hintTextStyle;
  final BorderStyle borderStyle;
  final double borderRadius;
  final double borderWidth;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final String prefixIconImagePath;
  final String hintText;
  final Color prefixIconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color fillColor;
  final bool filled;
  final bool obscured;
  final bool hasPrefixIcon;
  final int maxLines;
  final Icon icon;
  final String Function(String) validator;
  final String Function(String) onsave;
  final TextEditingController controller;
  Iterable<String> autofillHints;
  int maxLength;
  final TextInputType keybordtype;
  final bool autocorrect;
  final String Function(String) onchange;

  CustomTextFormField({
    this.autocorrect,
    this.onchange,
    this.keybordtype,
    this.icon,
    this.maxLength,
    this.autofillHints,
    this.controller,
    this.validator,
    this.onsave,
    this.hasPrefixIcon = false,
    this.prefixIconImagePath,
    this.maxLines = 1,
    this.textFormFieldStyle = Styles.normalTextStyle,
    this.hintTextStyle = Styles.normalTextStyle,
    this.borderStyle = BorderStyle.none,
    this.borderRadius = Sizes.RADIUS_12,
    this.borderWidth = Sizes.WIDTH_0,
    this.contentPaddingHorizontal = Sizes.PADDING_0,
    this.contentPaddingVertical = Sizes.PADDING_22,
    this.hintText,
    this.prefixIconColor = AppColors.secondaryText,
    this.borderColor = AppColors.greyShade1,
    this.focusedBorderColor = AppColors.greyShade1,
    this.enabledBorderColor = AppColors.greyShade1,
    this.fillColor = AppColors.fillColor,
    this.filled = true,
    this.obscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: onchange,
        autocorrect: autocorrect ?? false ? true : false,
        keyboardType: keybordtype,
        maxLength: maxLength,
        validator: validator,
        onSaved: onsave,
        controller: controller,
        style: textFormFieldStyle,
        maxLines: maxLines,
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
          prefixIcon: hasPrefixIcon ? icon : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingHorizontal,
            vertical: contentPaddingVertical,
          ),
          hintText: hintText,
          hintStyle: hintTextStyle,
          filled: filled,
          fillColor: fillColor,
        ),
        obscureText: obscured,
      ),
    );
  }

  Widget prefixImage() {
    if (prefixIconImagePath != null) {
      return ImageIcon(
        AssetImage(prefixIconImagePath),
        color: prefixIconColor,
      );
    }

    return null;
  }
}
