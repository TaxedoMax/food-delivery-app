import 'package:flutter/cupertino.dart';

class MainDecorators{
  static BoxDecoration defaultBoxDecoration(Color backgroundColor) => BoxDecoration(
      color: backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(20))
  );
}