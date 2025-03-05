import 'package:flutter/material.dart';

abstract final class AppColors {
  const AppColors();

  /// Primary color of the application
  static const primary = Color(0xff006175);

  /// Background Color
  static const white = Color(0xffffffff);

  /// Color used in text border and so on
  static const black = Color(0xff000000);

  /// Surface color for fields
  static const surface = Color(0xffF2F2F2);

  /// color for the text buttons
  static const actionText = Color(0xffC4C4C4);

  /// color for danger
  static const red = Color(0xffEE2323);

  /// transparent color
  static const transparent = Color(0x00000000);
}
