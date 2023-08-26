import 'package:flutter/material.dart' show MediaQueryData,BuildContext, MediaQuery,Size;

class ScreenSize {
  static late MediaQueryData _mediaQueryData;
  static void setMediaQuery(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  static Size get size => _mediaQueryData.size;
  static double get height => _mediaQueryData.size.height;
  static double get width => _mediaQueryData.size.width;
}
