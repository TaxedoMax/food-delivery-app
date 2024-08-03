import 'package:antons_app/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../../themes/main_theme/typography.dart';
import '../list_items/cart_item.dart';


class CartFragment extends StatefulWidget{
  const CartFragment({super.key});

  @override
  State<StatefulWidget> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(state is CartLoadingState)
                      const CircularProgressIndicator(),
                    if(state is CartUploadedState && state.purchases.isEmpty)
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
                    if(state is CartUploadedState && state.purchases.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => CartItem(purchase: state.purchases[index]),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: state.purchases.length),
                      ),
                  ],
                )
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
    );
  }
  
}