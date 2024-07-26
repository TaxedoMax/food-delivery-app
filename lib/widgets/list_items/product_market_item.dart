import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductMarketItem extends StatefulWidget {
  const ProductMarketItem({super.key, required this.product});
  final Product product;
  @override
  State<StatefulWidget> createState() => _ProductMarketItemState();

}

class _ProductMarketItemState extends State<ProductMarketItem>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(10),
      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 150,
            width: 150,
            decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
            child: Image.network(widget.product.imageUrl,
              errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/no_image.png',),
            ),
          ),
          Text(widget.product.name, style: MainTypography.defaultTextStyle),
          Text('${widget.product.weight.toString()} г', style: MainTypography.hintTextStyle),
          InkWell(
            child: Container(
              decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.main),
              alignment: Alignment.center,
              child: Text('${widget.product.price.toString()} руб', style: MainTypography.buttonTextStyle),
            ),
          )
        ],
      )
    );
  }

}