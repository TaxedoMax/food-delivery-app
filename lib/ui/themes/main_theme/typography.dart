import 'dart:ui';
import 'package:flutter/material.dart';

import 'main_color_scheme.dart';

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