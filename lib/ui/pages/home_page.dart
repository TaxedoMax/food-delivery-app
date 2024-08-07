import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart_bloc.dart';
import '../../bloc/product_list_bloc.dart';
import '../themes/main_theme/main_color_scheme.dart';
import '../themes/main_theme/main_decorations.dart';
import '../themes/main_theme/typography.dart';
import '../widgets/fragments/cart_fragment.dart';
import '../widgets/fragments/side_categories_fragment.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        title: const Text(
          'S-рынок',
          style: MainTypography.headingTextStyle,
        ),
        actions: [
        Container(
          width: 500,
          height: 50,
          decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const TextField(
            style: MainTypography.defaultTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.search),
              hintText: 'Найти на рынке',
              hintStyle: MainTypography.hintTextStyle,
              ),
          ),
        ),
          IconButton(
              onPressed: () => context.go('/login'),
              icon: const Icon(Icons.account_circle))
        ],
      ),

      body: MultiBlocProvider(
        providers: [
          BlocProvider<FragmentBloc>(
              create: (context) => FragmentBloc()..add(CategoryListOpenedEvent())
          ),
          BlocProvider<CategoryListBloc>(
              create: (context) => CategoryListBloc()..add(CategoryListUpdatedEvent())
              ),
          BlocProvider<ProductListBloc>(
            create: (context) => ProductListBloc(),
          ),
          BlocProvider<CartBloc>(
              create: (context) => CartBloc()..add(CartRequestedEvent())
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Side list (left)
              Expanded(
                flex: 15,
                child: Container(
                  alignment: Alignment.center,
                  decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                  padding: const EdgeInsets.all(10),
                  child: const SideCategoriesFragment()
                ),
              ),

              const SizedBox(width: 20),

              // Main space with goods
              Expanded(
                flex: 60,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                  child: BlocBuilder<FragmentBloc, Widget>(
                      builder: (context, state) {
                      return state;
                    }
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Basket
              Expanded(
                  flex: 25,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                    child: const CartFragment(),
                  )
              ),
            ],
          ),
        ),
      )
    );
  }

}