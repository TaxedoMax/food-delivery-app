import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasketFragment extends StatefulWidget{
  const BasketFragment({super.key});

  @override
  State<StatefulWidget> createState() => _BasketFragment();
}

class _BasketFragment extends State<BasketFragment>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 350,
          width: 350,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/basket_background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.main),
            child: const Text(
              'Заказать',
              style: MainTypography.buttonTextStyle,
            ),
          ),
        )
      ]
    );
  }
  
}