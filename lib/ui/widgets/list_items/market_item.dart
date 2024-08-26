import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc.dart';
import '../../../bloc/cart_bloc.dart';
import '../../../entities/product.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../../themes/main_theme/typography.dart';

class MarketItem extends StatefulWidget {
  const MarketItem({super.key, required this.product});
  final Product product;
  @override
  State<StatefulWidget> createState() => _MarketItemState();
}

class _MarketItemState extends State<MarketItem>{

  bool _canChangeCart = true;
  void _cartListener(context, cartState){
    setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: _cartListener,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Center(
                child: Image.network(widget.product.imageUrl ?? '',
                  // width: 150,
                  // height: 150,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/no_image.png',
                        // width: 150,
                        // height: 150,
                      ),
                ),
              ),
            ),

            FittedBox(child: Text(widget.product.name, style: MainTypography.defaultTextStyle)),
            Text('${widget.product.weight.toString()} г', style: MainTypography.hintTextStyle),
            Center(
              child: widget.product.amountInCart == 0
                  ? ElevatedButton(
                      onPressed: _canChangeCart
                        ? ()=> BlocProvider.of<CartBloc>(context).add(ProductAddedEvent(widget.product))
                        : null,
                      style: MainDecorators.defaultButtonStyle(),
                      child: Text('${widget.product.price.toString()} руб', style: MainTypography.buttonTextStyle),
                    )
                  : null
            )
          ],
        )
      ),
    );
  }

}