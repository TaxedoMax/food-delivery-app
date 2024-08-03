import 'package:antons_app/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../list_items/category_item.dart';

class CategoriesFragment extends StatefulWidget{
  const CategoriesFragment({super.key});
  @override
  State<StatefulWidget> createState() => _CategoriesFragmentState();
}

class _CategoriesFragmentState extends State<CategoriesFragment>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      builder: (context, state) {
        if(state is CategoryListUnknownState){
          return const CircularProgressIndicator();
        }
        else if(state is CategoryListKnownState){
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (BuildContext context, int index) => CategoryItem(category: state.categories[index]),
                ),
              ),
            ],
          );
        }
        throw Exception("Unknown state in CategoryListBloc");
      }
    );
  }

}