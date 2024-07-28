import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/bloc/product_list_bloc.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:antons_app/widgets/list_items/product_market_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketFragment extends StatefulWidget{
  final String group;
  const MarketFragment({super.key, required this.group});

  @override
  State<StatefulWidget> createState() => _MarketFragmentState();
}

class _MarketFragmentState extends State<MarketFragment>{
  // Product list initialization
  @override
  void initState(){
    super.initState();
    BlocProvider.of<ProductListBloc>(context).add(ProductListOpenedEvent(widget.group));
  }
  // Updating product list
  @override
  void didUpdateWidget(MarketFragment oldWidget){
    super.didUpdateWidget(oldWidget);
    if(widget.group != oldWidget.group){
      BlocProvider.of<ProductListBloc>(context).add(ProductListOpenedEvent(widget.group));
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
                onPressed: () => BlocProvider.of<FragmentBloc>(context).add(GroupsListOpenedEvent()),
                icon: const Icon(Icons.arrow_back, color: MainColorScheme.mainText),
            ),
            Text(
                widget.group,
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
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).size.width ~/ 350,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: (170 / 245)
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) => ProductMarketItem(product: state.products[index])
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

