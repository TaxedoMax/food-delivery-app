import 'package:antons_app/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/product.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../../themes/main_theme/typography.dart';


class CartItem extends StatefulWidget{
  const CartItem({super.key, required this.product});
  final Product product;
  @override
  State<StatefulWidget> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: Row(
          children: [
            // Product's image
            Image.network(widget.product.imageUrl ?? '',
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
                          InkWell(
                            onTap: () => BlocProvider.of<CartBloc>(context).add(PurchaseRemovedEvent(widget.product)),
                            child: const Icon(Icons.remove, color: MainColorScheme.mainText)
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(widget.product.quantity.toString(), style: MainTypography.defaultTextStyle),
                          ),

                          InkWell(
                              onTap: () => BlocProvider.of<CartBloc>(context).add(PurchaseAddedEvent(widget.product)),
                              child: const Icon(Icons.add, color: MainColorScheme.mainText)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // TODO: check discount
            Text('${widget.product.price * widget.product.quantity} руб', style: MainTypography.defaultTextStyle,)
          ],
        ),
      ),
    );
  }
  
}