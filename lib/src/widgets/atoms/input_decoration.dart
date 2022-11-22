import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';

class CostumTextBorder {
  static InputDecoration textfieldDecoration({
    required context,
    required hintText,
    required lableText,
    required IconData iconData,
    IconButton? suffixIcon,
  }) {
    return InputDecoration(
      //suffixIconColor: Colors.orange,
      hintText: hintText,
      labelText: lableText,
      suffixIcon: suffixIcon,
      prefixIcon: Icon(
        iconData,
        color: AppColors.black,
      ),
      focusColor: AppColors.black,
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.black,
        letterSpacing: 0.7,
      ),
      hintStyle: TextStyle(
        color: AppColors.black,
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
      ),
      errorStyle: const TextStyle(fontSize: 0, height: 0),
      errorText: null,

      focusedBorder: InputBorder.none,
      border: InputBorder.none,

      isDense: true,
    );
  }

  static TextStyle textfieldstyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColors.black,
    letterSpacing: 0.7,
  );
}
