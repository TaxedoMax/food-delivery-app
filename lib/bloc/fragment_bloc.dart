import 'package:antons_app/bloc/product_list_bloc.dart';
import 'package:antons_app/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/widgets/fragments/categories_fragment.dart';
import '../ui/widgets/fragments/market_fragment.dart';

class FragmentBloc extends Bloc<FragmentEvent, Widget>{
  FragmentBloc(): super(const CategoriesFragment()){
    on<CategoryClickedEvent>(_onCategoryClicked);
    on<CategoryListOpenedEvent>(_onCategoryListOpened);
  }

  _onCategoryClicked(CategoryClickedEvent event, Emitter emit) async {
    emit(MarketFragment(category: event.subCategory));
  }

  _onCategoryListOpened(CategoryListOpenedEvent event, Emitter emit) async {
    emit(const CategoriesFragment());
  }
}

abstract class FragmentEvent{}
class CategoryClickedEvent extends FragmentEvent{
  final Category subCategory;
  CategoryClickedEvent({required this.subCategory});
}
class CategoryListOpenedEvent extends FragmentEvent{}