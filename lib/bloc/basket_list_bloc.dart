import 'package:antons_app/repository/api_emulator.dart';
import 'package:antons_app/repository/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';
import '../models/purchase_model.dart';

class BasketListBloc extends Bloc<PurchaseListEvent, PurchaseListState>{
  BasketListBloc(): super(PurchaseListLoadingState()){
    on<PurchaseListRequestedEvent>(_onPurchaseListRequestedEvent);
    on<PurchaseAddedEvent>(_onPurchaseAddedEvent);
  }

  _onPurchaseListRequestedEvent(PurchaseListRequestedEvent event, Emitter emit) async {
    emit(PurchaseListLoadingState());
    var purchases = await MainRepository.getPurchases();
    emit(PurchaseListUploadedState(purchases));
  }

  _onPurchaseAddedEvent(PurchaseAddedEvent event, Emitter emit) async {
    MainRepository.basketUpdateRequestStarted();
    // Adding to cart in cache
    debugPrint("1");
    MainRepository.addPurchaseToCache(event.product);
    // Building information
    debugPrint("2");
    emit(PurchaseListUploadedState(MainRepository.getPurchaseFromCache()));
    // Adding product to api cart
    debugPrint("3");
    await MainRepository.addPurchase(event.product);

    MainRepository.basketUpdateRequestFinished();

    debugPrint("4");
    // Checking if everything is ok, only when all requests finished
    if(MainRepository.canUpdateBasketCache()){
      debugPrint("Started checking");
      bool status = await MainRepository.updateBasketCache();
      debugPrint("Finished checking");
      if(!status){
        debugPrint("5");
        emit(PurchaseListUploadedState(MainRepository.getPurchaseFromCache()));
      }
    }
  }

  _onPurchaseRemovedEvent(PurchaseRemovedEvent event, Emitter emit){
    MainRepository.basketUpdateRequestStarted();

  }
}

abstract class PurchaseListEvent{}
class PurchaseListRequestedEvent extends PurchaseListEvent{}
class PurchaseAddedEvent extends PurchaseListEvent{
  final Product product;
  PurchaseAddedEvent(this.product);
}
class PurchaseRemovedEvent extends PurchaseListEvent{
  final Product product;
  PurchaseRemovedEvent(this.product);
}

abstract class PurchaseListState{}
class PurchaseListLoadingState extends PurchaseListState{}
class PurchaseListUploadedState extends PurchaseListState{
  final List<Purchase> purchases;
  PurchaseListUploadedState(this.purchases);
}