import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primary =
      MaterialColor(_greenPrimaryValue, <int, Color>{
    50: Color(0xFFE7F4E3),
    100: Color(0xFFC3E4B8),
    200: Color(0xFF9CD289),
    300: Color(0xFF74BF59),
    400: Color(0xFF56B236),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF329C10),
    700: Color(0xFF2B920D),
    800: Color(0xFF24890A),
    900: Color(0xFF177805),
  });
  static const int _greenPrimaryValue = 0xFF38A412;
  static const Color black = Color(0xFF333333);
  static const Color greyDark = Color(0xFF999999);
  static const Color greyLight = Color(0xFFF3F4F8);
  static const Color secondary = Color(0xFFF05158);

  static const Color blue = Color(0xff108BD0);
  static const Color darkBlue = Color(0xff122F78);

  static const Color red = Color(0xffF23B14);
  static const Color mainGreen = Color(0xff20C3AF);
  static const Color textBlack = Color(0xff525464);
  static const Color textLightBlack = Color(0xff838391);
  static const Color offWhite = Color(0xffF7F7F7);
  static const Color pinkLight = Color(0xffFFB19D);
  static const Color active = Color(0xff22A45D);
  static const Color orange = Colors.orangeAccent;

  static const LinearGradient busygradient =
      LinearGradient(begin: Alignment.bottomLeft, stops: [
    0,
    1
  ], colors: [
    Color.fromARGB(255, 238, 87, 70),
    Color.fromARGB(255, 91, 62, 24),
  ]);
}
