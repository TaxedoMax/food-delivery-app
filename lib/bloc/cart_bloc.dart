import 'dart:async';

import 'package:antons_app/bloc/auth_bloc.dart';
import 'package:antons_app/exception/unauthorized_exception.dart';
import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../entities/product.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  AuthBlocState? authBlocState;
  late StreamSubscription<AuthBlocState> authStreamSubscription;

  final _cartUseCase = GetIt.instance<CartUseCase>();

  CartBloc(Stream<AuthBlocState> stream): super(CartLoadingState()){
    // Subscribe to auth state
    authStreamSubscription = stream.listen(_onAuthStateChanged);

    on<CartInitEvent>(_onCartInitEvent);
    on<CartUpdateRequestedEvent>(_onCartUpdateRequestedEvent);
    on<ProductAddedEvent>(_onProductAddedEvent);
    on<ProductRemovedEvent>(_onProductRemovedEvent);
    on<CartOrderedEvent>(_onCartOrderedEvent);
  }

  @override
  close() async {
    authStreamSubscription.cancel();
    super.close();
  }

  _onCartInitEvent(CartInitEvent event, Emitter emit) async {
    try{
      emit(CartLoadingState());
      var cart = await _cartUseCase.getCart();
      debugPrint('Cart updated');
      emit(CartUploadedState(cart));
    }
    on Exception{
      // TODO: unfinished
      emit(CartUploadedState([]));
    }
  }

  _onAuthStateChanged(AuthBlocState authBlocState){
    this.authBlocState = authBlocState;
    if(authBlocState is! LoadingAuthState){
      add(CartUpdateRequestedEvent());
    }
  }

  _onCartUpdateRequestedEvent(CartUpdateRequestedEvent event, Emitter emit) async {
    try{
      emit(CartLoadingState());
      var cart = await _cartUseCase.getCart();
      debugPrint('Cart updated');
      emit(CartUploadedState(cart));
    }
    on Exception catch(e){
      if(e is UnauthorizedException){
        emit(CartUploadedWithErrorState([], 401));
      }
    }
  }

  _onProductAddedEvent(ProductAddedEvent event, Emitter emit) async {
    try{
      var oldCart = Product.cloneList(_cartUseCase.getCartCache());
      emit(CartWaitingState(oldCart));

      await _cartUseCase.addProduct(event.product);
      var newCart = await _cartUseCase.getCart();

      final (changesDelta, changes) = _cartUseCase.cartsDifference(oldCart, newCart);
      if(changes.length == 1 && changesDelta[0] == 1 && changes[0].id == event.product.id){
        emit(CartUploadedState(newCart));
      }
      else{
        emit(CartUploadedWithErrorState(newCart, 422));
      }
    }
    on Exception catch(e){
      if(e is UnauthorizedException){
        emit(CartUploadedWithErrorState(_cartUseCase.getCartCache(), 401));
      }
    }
  }

  _onProductRemovedEvent(ProductRemovedEvent event, Emitter emit) async {
    try{
      var oldCart = Product.cloneList(_cartUseCase.getCartCache());
      emit(CartWaitingState(oldCart));

      await _cartUseCase.removeProduct(event.product);
      var newCart = await _cartUseCase.getCart();

      final (changesDelta, changes) = _cartUseCase.cartsDifference(oldCart, newCart);
      if(changes.length == 1 && changesDelta[0] == -1 && changes[0].id == event.product.id){
        emit(CartUploadedState(newCart));
      }
      else{
        emit(CartUploadedWithErrorState(newCart, 422));
      }
    }
    on Exception catch(e){
      if(e is UnauthorizedException){
        emit(CartUploadedWithErrorState(_cartUseCase.getCartCache(), 401));
      }
    }
  }

  _onCartOrderedEvent(CartOrderedEvent event, Emitter emit) async{
    try{
      emit(CartLoadingState());
      bool status = await _cartUseCase.order();
      if(status){
        List<Product> cart = await _cartUseCase.getCart();
        emit(CartUploadedState(cart));
      }
      else{
        List<Product> cart = await _cartUseCase.getCart();
        emit(CartUploadedWithErrorState(cart, 0));
      }
    }
    on Exception catch(e){
      if(e is UnauthorizedException){
        emit(CartUploadedWithErrorState(_cartUseCase.getCartCache(), 401));
      }
    }
  }


}

abstract class CartEvent{}
class CartInitEvent extends CartEvent{}
class CartUpdateRequestedEvent extends CartEvent{}
class ProductAddedEvent extends CartEvent{
  final Product product;
  ProductAddedEvent(this.product);
}
class ProductRemovedEvent extends CartEvent{
  final Product product;
  ProductRemovedEvent(this.product);
}
class CartOrderedEvent extends CartEvent{}


abstract class CartState{}
class CartLoadingState extends CartState{}
class CartUploadedState extends CartState{
  final List<Product> cart;
  CartUploadedState(this.cart);
}
class CartWaitingState extends CartUploadedState{
  CartWaitingState(super.cart);
}
class CartUploadedWithErrorState extends CartUploadedState{
  int errorStatus;
  CartUploadedWithErrorState(super.cart, this.errorStatus);
}