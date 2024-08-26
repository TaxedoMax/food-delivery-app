import 'dart:async';

import 'package:antons_app/entities/category.dart';
import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:antons_app/use_case/product_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../entities/product.dart';
import 'cart_bloc.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState>{

  final _productListUseCase = GetIt.instance<ProductListUseCase>();
  CartState? _cartState;
  StreamSubscription<CartState>? _cartStreamSubscription;

  ProductListBloc([Stream<CartState>? cartStream]) : super(ProductListLoadingState(Category.empty())){
    _cartStreamSubscription = cartStream?.listen(_onCartStateChanged);
    on<ProductListOpenedEvent>(_onProductListOpenedEvent);
    on<_ProductListUpdatedEvent>(_onProductListUpdatedEvent);
  }

  void _onCartStateChanged(CartState cartState){
    debugPrint('emited');
    _cartState = cartState;
    ProductListState currentState = state;
    if(cartState is CartUploadedState && currentState is ProductListUploadedState){
      var currentProducts = currentState.products;
      var currentCategory = currentState.category;
      var currentCart = cartState.cart;
      debugPrint('Product list updated ${DateTime.now()}');

      bool needUpdate = _updateProducts(currentProducts, currentCart);

      if(needUpdate) add(_ProductListUpdatedEvent(currentCategory, currentProducts));
    }
  }

  /// Returns true if updates were needed, false if oldList don't contain updatable products
  bool _updateProducts(List<Product> oldList, List<Product> updatesList){
    bool updatePushed = false;
    for(var newProduct in updatesList){
      int index = oldList.indexWhere((product) => product == newProduct);
      if(index != -1){
        oldList[index] = newProduct;
        updatePushed = true;
      }
    }
    return updatePushed;
  }

  _onProductListOpenedEvent(ProductListOpenedEvent event, Emitter emit) async{
    emit(ProductListLoadingState(event.category));
    var products = await _productListUseCase.getProductsByCategoryId(event.category.id);
    if(_cartState != null && _cartState is CartUploadedState){
      CartUploadedState cartUploadedState = _cartState as CartUploadedState;
      _updateProducts(products, cartUploadedState.cart);
    }
    emit(ProductListUploadedState(event.category, products));
  }

  _onProductListUpdatedEvent(_ProductListUpdatedEvent event, Emitter emit) {
    emit(ProductListUploadedState(event.category, event.products));
  }

  @override
  Future<void> close() async {
    _cartStreamSubscription?.cancel();
    super.close();
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
  List<Product> products;
  ProductListUploadedState(super.category, this.products);
}

abstract class ProductListEvent{}
class ProductListOpenedEvent extends ProductListEvent{
  final Category category;
  ProductListOpenedEvent(this.category);
}
class _ProductListUpdatedEvent extends ProductListOpenedEvent{
  final List<Product> products;
  _ProductListUpdatedEvent(super.category, this.products);
}