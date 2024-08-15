import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc.dart';
import '../../../bloc/cart_bloc.dart';
import '../../../entities/product.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../../themes/main_theme/typography.dart';

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
      padding: const EdgeInsets.all(10),
      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(widget.product.imageUrl ?? '',
              errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/no_image.png',),
            ),
          ),

          Text(widget.product.name, style: MainTypography.defaultTextStyle),
          Text('${widget.product.weight.toString()} г', style: MainTypography.hintTextStyle),
          BlocBuilder<AuthBloc, AuthBlocState>(
            builder: (context, authState) {
              return InkWell(
                onTap: ()=> BlocProvider.of<CartBloc>(context).add(ProductAddedEvent(widget.product)),
                child: Container(
                  decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.main),
                  alignment: Alignment.center,
                  child: Text('${widget.product.price.toString()} руб', style: MainTypography.buttonTextStyle),
                ),
              );
            }
          )
        ],
      )
    );
  }

}