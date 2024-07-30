import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/bloc/group_list_bloc.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:antons_app/widgets/fragments/basket_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_list_bloc.dart';
import '../bloc/basket_list_bloc.dart';
import '../widgets/fragments/side_groups_fragment.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(

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
              onPressed: (){},
              icon: const Icon(Icons.account_circle))
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Colors.white,
      ),

      body: MultiBlocProvider(
        providers: [
          BlocProvider<FragmentBloc>(
              create: (context) => FragmentBloc()..add(GroupsListOpenedEvent())
          ),
          BlocProvider<GroupListBloc>(
              create: (context) => GroupListBloc()..add(GroupListUpdatedEvent())
              ),
          BlocProvider<ProductListBloc>(
            create: (context) => ProductListBloc(),
          ),
          BlocProvider<BasketListBloc>(
              create: (context) => BasketListBloc()..add(PurchaseListRequestedEvent())
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
                  child: const SideGroupFragment()
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
                    child: const BasketFragment(),
                  )
              ),
            ],
          ),
        ),
      )
    );
  }

}