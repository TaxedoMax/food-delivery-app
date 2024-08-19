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

  bool _canChangeCart = true;
  bool get _canAdd => widget.product.canBeAddedToCart();

  void _cartListener(BuildContext context, CartState cartState){
    switch(cartState.runtimeType){
      case CartLoadingState:
        _canChangeCart = false;
      case CartUploadedWithErrorState:
        _canChangeCart = true;
      case CartUploadedState:
        _canChangeCart = true;
      case CartWaitingState:
        _canChangeCart = false;
      default:
        _canChangeCart = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: _cartListener,
      child: Padding(
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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: _canChangeCart
                                      ? () => BlocProvider.of<CartBloc>(context).add(ProductRemovedEvent(widget.product))
                                      : null,
                                  icon: const Icon(Icons.remove, color: MainColorScheme.mainText)
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(widget.product.amountInCart.toString(), style: MainTypography.defaultTextStyle),
                                ),

                                IconButton(
                                    onPressed: _canAdd && _canChangeCart
                                        ? () => BlocProvider.of<CartBloc>(context).add(ProductAddedEvent(widget.product))
                                        : null,
                                    color: MainColorScheme.mainText,
                                    disabledColor: MainColorScheme.hintText,
                                    icon: const Icon(Icons.add)
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // TODO: check discount
              Text('${widget.product.price * widget.product.amountInCart} руб', style: MainTypography.defaultTextStyle,)
            ],
          ),
        ),
      ),
    );
  }
  
}