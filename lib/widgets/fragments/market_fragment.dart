import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/in_memory_db.dart';
import 'package:antons_app/models/product_model.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:antons_app/widgets/list_items/product_market_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketFragment extends StatefulWidget{
  final String group;
  const MarketFragment({super.key, required this.group});

  @override
  State<StatefulWidget> createState() => _MarketFragmentState();
}

class _MarketFragmentState extends State<MarketFragment>{
  late List<Product> products;
  @override
  Widget build(BuildContext context) {
    // TODO: Remove initialization
    products = InMemoryDB.products.containsKey(widget.group) ? (InMemoryDB.products[widget.group])! : [];
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 1300 ? 4 : 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: (170 / 245)
                ),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) => ProductMarketItem(product: products[index])
            ),
          )
        )
      ],
    );
  }

}

