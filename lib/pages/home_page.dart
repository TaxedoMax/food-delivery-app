import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/in_memory_db.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:antons_app/widgets/fragments/basket_fragment.dart';
import 'package:antons_app/widgets/fragments/groups_fragment.dart';
import 'package:antons_app/widgets/fragments/side_groups_fragment.dart';
import 'package:antons_app/widgets/list_items/group_list_item.dart';
import 'package:antons_app/widgets/list_items/side_group_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/group_model.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

List<Group> groups = InMemoryDB.groupsList;

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

      body: BlocProvider<FragmentBloc>(
        create: (context) => FragmentBloc(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Side list (left)
              Expanded(
                flex: 15,
                child: Container(
                  decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                  padding: const EdgeInsets.all(10),
                  child: SideGroupFragment(groups: groups)
                ),
              ),

              const SizedBox(width: 20),

              // Main space with goods
              Expanded(
                flex: 60,
                child: BlocBuilder<FragmentBloc, Widget>(
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                      child: state,
                    );
                  }
                ),
              ),

              const SizedBox(width: 20),

              // Basket
              Expanded(
                  flex: 25,
                  child: Container(
                    height: 435,
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