import 'package:antons_app/bloc/fragment_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Container(
          child: ProductMarketItem(product: Product(name: 'Да', price: 100, weight: 50, imageUrl: ''),)
        )
      ],
    );
  }

}

