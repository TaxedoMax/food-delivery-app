import 'package:antons_app/entities/category.dart';
import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:antons_app/use_case/product_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../entities/product.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState>{

  var productListUseCase = GetIt.instance<ProductListUseCase>();

  ProductListBloc() : super(ProductListLoadingState(Category(id: '', name: '', imageUrl: '', subCategories: []))) {
    on<ProductListOpenedEvent>(_onProductListOpenedEvent);
  }

  _onProductListOpenedEvent(ProductListOpenedEvent event, Emitter emit) async{
    emit(ProductListLoadingState(event.category));
    var products = await productListUseCase.getProductByCategoryId(event.category.id);
    emit(ProductListUploadedState(event.category, products));
  }

}

abstract class ProductListState{
  final Category category;
  ProductListState(this.category);
}
class ProductListLoadingState extends ProductListState{
  ProductListLoadingState(super.category);
}
class ProductListUploadedState extends ProductListState{
  final List<Product> products;
  ProductListUploadedState(super.category, this.products);
}

abstract class ProductListEvent{}
class ProductListOpenedEvent extends ProductListEvent{
  final Category category;
  ProductListOpenedEvent(this.category);
}