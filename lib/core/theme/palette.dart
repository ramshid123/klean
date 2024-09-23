import 'package:flutter/material.dart';

class ColorConstants {
  static const Color bgColor = Color(0xffF8F8F8);
  static const Color greenColor = Color(0xff4FB15E);
  static const Color liteGreenColor = Color(0xffD7FFEA);
  static const Color orangeColor = Color(0xffFF6B4A);
  static const Color redColor = Color(0xffFF4B4B);
  static const greenGradient = LinearGradient(
    colors: [
      Color(0xff5FCD70),
      Color(0xff0E826B),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
