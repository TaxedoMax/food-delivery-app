import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:antons_app/use_case/product_lict_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState>{

  var productListUseCase = GetIt.instance<ProductListUseCase>();

  ProductListBloc() : super(ProductListLoadingState("")) {
    on<ProductListOpenedEvent>(_onProductListOpenedEvent);
  }

  _onProductListOpenedEvent(ProductListOpenedEvent event, Emitter emit) async{
    emit(ProductListLoadingState(event.category));
    var products = await productListUseCase.getProductByCategoryName(event.category);
    emit(ProductListUploadedState(event.category, products));
  }

}

abstract class ProductListState{
  final String category;
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
  final String category;
  ProductListOpenedEvent(this.category);
}