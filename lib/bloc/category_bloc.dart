import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:antons_app/models/category_model.dart';
import 'package:antons_app/use_case/category_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState>{

  var categoryUseCase = GetIt.instance<CategoryUseCase>();

  CategoryListBloc(): super(CategoryListUnknownState()){
    on<CategoryListUpdatedEvent>(_onCategoryListUpdated);
  }

  _onCategoryListUpdated(CategoryListUpdatedEvent event, Emitter emit) async {
    emit(CategoryListUnknownState());
    var categories = await categoryUseCase.getCategoryList();
    emit(CategoryListKnownState(categories: categories));
  }
}


abstract class CategoryListEvent{}
class CategoryListUpdatedEvent extends CategoryListEvent{}
class CategoryListUnknownEvent extends CategoryListEvent{}

abstract class CategoryListState{}

class CategoryListUnknownState extends CategoryListState{}

class CategoryListKnownState extends CategoryListState{
  List<Category> categories;
  CategoryListKnownState({required this.categories});
}