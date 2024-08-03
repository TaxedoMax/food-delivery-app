import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';
import '../models/purchase_model.dart';

class CartBloc extends Bloc<CartEvent, CartState>{

  var cartUseCase = GetIt.instance<CartUseCase>();

  CartBloc(): super(CartLoadingState()){
    on<CartRequestedEvent>(_onPurchaseListRequestedEvent);
    on<PurchaseAddedEvent>(_onPurchaseAddedEvent);
    on<PurchaseRemovedEvent>(_onPurchaseRemovedEvent);
  }

  _onPurchaseListRequestedEvent(CartRequestedEvent event, Emitter emit) async {
    emit(CartLoadingState());
    var purchases = await cartUseCase.getPurchases();
    emit(CartUploadedState(purchases));
  }

  _onPurchaseAddedEvent(PurchaseAddedEvent event, Emitter emit) async {
    cartUseCase.cartUpdateRequestStarted();
    // Adding to cart in cache
    debugPrint("1");
    cartUseCase.addPurchaseToCache(event.product);
    // Building information
    debugPrint("2");
    emit(CartUploadedState(cartUseCase.getPurchaseFromCache()));
    // Adding product to api cart
    debugPrint("3");
    await cartUseCase.addPurchase(event.product);

    cartUseCase.cartUpdateRequestFinished();

    debugPrint("4");
    // Checking if everything is ok, only when all requests finished
    if(cartUseCase.canUpdateCartCache()){
      debugPrint("Started checking");
      bool status = await cartUseCase.updateCartCache();
      debugPrint("Finished checking");
      if(!status){
        debugPrint("5");
        emit(CartUploadedState(cartUseCase.getPurchaseFromCache()));
      }
    }
  }

  _onPurchaseRemovedEvent(PurchaseRemovedEvent event, Emitter emit) async {
    cartUseCase.cartUpdateRequestStarted();
    cartUseCase.removePurchaseFromCache(event.product);
    emit(CartUploadedState(cartUseCase.getPurchaseFromCache()));
    await cartUseCase.removePurchase(event.product);
    cartUseCase.cartUpdateRequestFinished();

    if(cartUseCase.canUpdateCartCache()){
      debugPrint("Started checking");
      bool status = await cartUseCase.updateCartCache();
      debugPrint("Finished checking");
      if(!status){
        debugPrint("5");
        emit(CartUploadedState(cartUseCase.getPurchaseFromCache()));
      }
    }
  }
}

abstract class CartEvent{}
class CartRequestedEvent extends CartEvent{}
class PurchaseAddedEvent extends CartEvent{
  final Product product;
  PurchaseAddedEvent(this.product);
}
class PurchaseRemovedEvent extends CartEvent{
  final Product product;
  PurchaseRemovedEvent(this.product);
}

abstract class CartState{}
class CartLoadingState extends CartState{}
class CartUploadedState extends CartState{
  final List<Purchase> purchases;
  CartUploadedState(this.purchases);
}