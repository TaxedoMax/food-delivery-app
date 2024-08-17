import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/bloc/product_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/category.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/typography.dart';
import '../list_items/product_market_item.dart';

class MarketFragment extends StatefulWidget{
  final Category category;
  const MarketFragment({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _MarketFragmentState();
}

class _MarketFragmentState extends State<MarketFragment>{
  // Product list initialization
  @override
  void initState(){
    super.initState();
    BlocProvider.of<ProductListBloc>(context).add(ProductListOpenedEvent(widget.category));
  }
  // Updating product list
  @override
  void didUpdateWidget(MarketFragment oldWidget){
    super.didUpdateWidget(oldWidget);
    if(widget.category != oldWidget.category){
      BlocProvider.of<ProductListBloc>(context).add(ProductListOpenedEvent(widget.category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Something like AppBar
        Row(
          children: [
            IconButton(
                onPressed: () => BlocProvider.of<FragmentBloc>(context).add(CategoryListOpenedEvent()),
                icon: const Icon(Icons.arrow_back, color: MainColorScheme.mainText),
            ),
            Text(
                widget.category.name,
                style: MainTypography.headingTextStyle
            ),
          ],
        ),

        // Body
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                if(state is ProductListLoadingState){
                  return const CircularProgressIndicator();
                }
                else if(state is ProductListUploadedState){
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: constraints.maxWidth ~/ 150,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: (170 / 245)
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext context, int index) => ProductMarketItem(product: state.products[index])
                      );
                    }
                  );
                }

                throw Exception("Unexpected state (ProductListState, MarketFragment)");
              }
            ),
          )
        )
      ],
    );
  }

}

