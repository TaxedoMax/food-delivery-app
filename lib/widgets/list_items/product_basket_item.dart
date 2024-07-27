import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductBasketItem extends StatefulWidget{
  const ProductBasketItem({super.key, required this.product, required this.amount});
  final Product product;
  final int amount;
  @override
  State<StatefulWidget> createState() => _ProductBasketItemState();
}

class _ProductBasketItemState extends State<ProductBasketItem>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: Row(
          children: [
            // Product's image
            Image.network(widget.product.imageUrl,
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/no_image.png', width: 100, height: 100,)
            ),

            // Product info without price
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name, style: MainTypography.defaultTextStyle),
                    Text('${widget.product.weight.toString()} г', style: MainTypography.hintTextStyle),
                    // Button +/-
                    Container(
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InkWell(
                            child: Icon(Icons.remove, color: MainColorScheme.mainText)
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(widget.amount.toString(), style: MainTypography.defaultTextStyle),
                          ),

                          const InkWell(
                              child: Icon(Icons.add, color: MainColorScheme.mainText)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            Text('${widget.product.price * widget.amount} руб', style: MainTypography.defaultTextStyle,)
          ],
        ),
      ),
    );
  }
  
}