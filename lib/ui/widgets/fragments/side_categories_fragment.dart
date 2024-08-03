import 'package:antons_app/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../list_items/side_category_item.dart';

class SideCategoriesFragment extends StatelessWidget{
  const SideCategoriesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      builder: (context, state) {
        if(state is CategoryListUnknownState){
          return const CircularProgressIndicator();
        }
        else if (state is CategoryListKnownState){
          return ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (BuildContext context, int index) => SideCategoryItem(category: state.categories[index]),
          );
        }
        throw Exception("Unexpected state (CategoriesListBloc, SideCategoriessFragment)");
      }
    );
  }

}