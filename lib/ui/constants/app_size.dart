import 'package:flutter/material.dart';

class AppSize {
  static double myHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double myWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}