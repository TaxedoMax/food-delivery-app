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
  late StreamSubscription<AuthBlocState> streamSubscription;

  final _cartUseCase = GetIt.instance<CartUseCase>();

  CartBloc(Stream<AuthBlocState> stream): super(CartLoadingState()){
    // Subscribe to auth state
    streamSubscription = stream.listen(_onAuthStateChanged);

    on<CartUpdateRequestedEvent>(_onCartUpdateRequestedEvent);
    on<ProductAddedEvent>(_onProductAddedEvent);
    on<ProductRemovedEvent>(_onProductRemovedEvent);
    on<CartOrderedEvent>(_onCartOrderedEvent);
  }

  @override
  close() async {
    streamSubscription.cancel();
    super.close();
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
        _cartUseCase.clearCache();
        emit(CartUploadedWithErrorState(_cartUseCase.getCartFromCache(), 401));
      }
    }
  }

  _onProductAddedEvent(ProductAddedEvent event, Emitter emit) async {
    try{
      _cartUseCase.cartUpdateRequestStarted();
      // Adding to cached cart
      debugPrint("1");
      _cartUseCase.addProductToCache(event.product);
      // Building information
      debugPrint("2");
      emit(CartUploadedState(_cartUseCase.getCartFromCache()));
      // Adding product to api cart
      debugPrint("3");
      await _cartUseCase.addProduct(event.product);

      _cartUseCase.cartUpdateRequestFinished();

      debugPrint("4");
      // Checking if everything is ok, only when all requests finished
      if(_cartUseCase.canUpdateCartCache()){
        debugPrint("Started checking");
        bool status = await _cartUseCase.updateCartCache();
        debugPrint("Finished checking");
        if(!status){
          debugPrint("5");
          emit(CartUploadedWithErrorState(_cartUseCase.getCartFromCache(), 422));
        }
      }
    } on Exception catch(e){
      if(e is UnauthorizedException){
        _cartUseCase.clearCache();
        emit(CartUploadedWithErrorState(_cartUseCase.getCartFromCache(), 401));
      }
    }
  }

  _onProductRemovedEvent(ProductRemovedEvent event, Emitter emit) async {
    try{
      _cartUseCase.cartUpdateRequestStarted();
      _cartUseCase.removeProductFromCache(event.product);
      emit(CartUploadedState(_cartUseCase.getCartFromCache()));
      await _cartUseCase.removeProduct(event.product);
      _cartUseCase.cartUpdateRequestFinished();

      if(_cartUseCase.canUpdateCartCache()){
        debugPrint("Started checking");
        bool status = await _cartUseCase.updateCartCache();
        debugPrint("Finished checking");
        if(!status){
          debugPrint("5");
          emit(CartUploadedWithErrorState(_cartUseCase.getCartFromCache(), 422));
        }
      }
    }
    on Exception catch(e){
      if(e is UnauthorizedException){
        _cartUseCase.clearCache();
        emit(CartUploadedWithErrorState(_cartUseCase.getCartFromCache(), 401));
      }
    }
  }

  _onCartOrderedEvent(CartOrderedEvent event, Emitter emit) async{
    try{
      emit(CartLoadingState());
      bool status = await _cartUseCase.order();
      if(status){
        _cartUseCase.clearCache();
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
        _cartUseCase.clearCache();
        emit(CartUploadedWithErrorState(_cartUseCase.getCartFromCache(), 401));
      }
    }
  }


}

abstract class CartEvent{}
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
class CartUploadedWithErrorState extends CartUploadedState{
  int errorStatus;
  CartUploadedWithErrorState(super.cart, this.errorStatus);
}
class CartEmptyState extends CartState{}
class CartUnknownState extends CartState{}