import 'package:antons_app/bloc/basket_list_bloc.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:antons_app/widgets/list_items/purchase_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';

class BasketFragment extends StatefulWidget{
  const BasketFragment({super.key});

  @override
  State<StatefulWidget> createState() => _BasketFragment();
}

class _BasketFragment extends State<BasketFragment>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketListBloc, PurchaseListState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(state is PurchaseListLoadingState)
                      const CircularProgressIndicator(),
                    if(state is PurchaseListUploadedState && state.purchases.isEmpty)
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
                    if(state is PurchaseListUploadedState && state.purchases.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => PurchaseItem(purchase: state.purchases[index]),
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