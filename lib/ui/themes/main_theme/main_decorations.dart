import 'package:antons_app/ui/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/ui/themes/main_theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDecorators{
  static BoxDecoration defaultBoxDecoration(Color backgroundColor) => BoxDecoration(
      color: backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(20))
  );

  static ButtonStyle defaultButtonStyle() => ElevatedButton.styleFrom(
    backgroundColor: MainColorScheme.main,
    foregroundColor: MainColorScheme.mainLight,
    elevation: 5,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))
    )
  );
}