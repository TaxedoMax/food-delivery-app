import 'package:antons_app/repository/in_memory_db.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState>{
  ProductListBloc() : super(ProductListLoadingState("")) {
    on<ProductListOpenedEvent>(_onProductListOpenedEvent);
  }

  _onProductListOpenedEvent(ProductListOpenedEvent event, Emitter emit) async{
    emit(ProductListLoadingState(event.group));
    var products = await InMemoryDB.getProductByGroupName(event.group);
    emit(ProductListUploadedState(event.group, products));
  }

}

abstract class ProductListState{
  final String group;
  ProductListState(this.group);
}
class ProductListLoadingState extends ProductListState{
  ProductListLoadingState(super.group);
}
class ProductListUploadedState extends ProductListState{
  final List<Product> products;
  ProductListUploadedState(super.group, this.products);
}

abstract class ProductListEvent{}
class ProductListOpenedEvent extends ProductListEvent{
  final String group;
  ProductListOpenedEvent(this.group);
}