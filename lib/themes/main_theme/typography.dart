import 'dart:ui';

import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:flutter/material.dart';

class MainTypography{
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 21,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    color: MainColorScheme.mainText,
  );

  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 15,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    color: MainColorScheme.mainText,
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontSize: 15,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    color: MainColorScheme.hintText,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 15,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    color: MainColorScheme.backgroundShadow,
  );
}