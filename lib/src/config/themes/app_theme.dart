import 'package:flutter/material.dart';

import 'colors.dart';

enum FontFamilyType {
  exo,
}

extension FontFamlilyExtension on FontFamilyType {
  String? name() {
    switch (this) {
      case FontFamilyType.exo:
        return "exo2";
    }
  }
}

class AppTheme {
  static FontFamilyType fontFamilyType = FontFamilyType.exo;

  static TextStyle headline1 = TextStyle(
    color: AppColors.black,
    height: 48.0 / 36.0,
    // line height calculated as is fontSize * height so, <expected-height>/<font-size>
    fontSize: 36.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle headline2Bold = TextStyle(
    color: AppColors.black,
    height: 36.0 / 18.0,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle heading2Regular = TextStyle(
    color: AppColors.black,
    height: 36.0 / 18.0,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle button = TextStyle(
    color: AppColors.black,
    height: 26.0 / 18.0,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle captionBold = TextStyle(
    color: AppColors.black,
    height: 22.0 / 16.0,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle captionRegular = TextStyle(
    color: AppColors.black,
    height: 22.0 / 16.0,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle textBold = TextStyle(
    color: AppColors.black,
    height: 20.0 / 14.0,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle textRegular = TextStyle(
    color: AppColors.black,
    height: 20.0 / 14.0,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle subHeading = TextStyle(
    color: AppColors.black,
    height: 20.0 / 12.0,
    fontSize: 12.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamilyType.name(),
    leadingDistribution: TextLeadingDistribution.even,
  );

  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: AppColors.primary,
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // fontFamily: GoogleFonts.sourceSansPro().fontFamily,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: captionBold,
        floatingLabelStyle: captionBold,
        hintStyle: captionRegular.copyWith(color: AppColors.greyDark),
        counterStyle: subHeading.copyWith(
          color: AppColors.greyDark,
        ),
        errorStyle: subHeading.copyWith(color: Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.greyDark, width: 1),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.greyDark, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
      textTheme: TextTheme(
        headline1: headline1,
        headline2: headline2Bold,
        headline3: heading2Regular,
        subtitle1: captionBold,
        subtitle2: captionRegular,
        bodyText1: textBold,
        bodyText2: textRegular,
        caption: subHeading,
        button: button,
      ),
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: AppColors.black),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: TextStyle(color: AppColors.black),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedLabelStyle: captionBold,
        unselectedLabelStyle: captionRegular,
      ),
    );
  }
}
