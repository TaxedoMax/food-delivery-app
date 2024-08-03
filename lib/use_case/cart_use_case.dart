import 'dart:core';

import 'package:antons_app/models/product_model.dart';
import 'package:antons_app/repository/api_emulator.dart';
import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';
import '../models/purchase_model.dart';

class CartUseCase{
  List<Purchase>? _cartCache;

  // This var, and all methods with it is necessary to understand,
  // when we can check if cart in cache and actual cart are same,
  // and there are no mistakes. If we check after every operation,
  // either amount of products will change
  // from one value to another, or buttons will freeze.
  int _runningCartUpdateRequests = 0;

  bool canUpdateCartCache(){
    return _runningCartUpdateRequests == 0;
  }

  void cartUpdateRequestStarted(){
    _runningCartUpdateRequests++;
  }

  void cartUpdateRequestFinished(){
    _runningCartUpdateRequests--;
  }


  Future<List<Purchase>> getPurchases() async{
    _cartCache ??= await APIEmulator.getPurchases();
    return _cartCache!;
  }

  List<Purchase> getPurchaseFromCache(){
    return _cartCache ?? [];
  }

  void addPurchaseToCache(Product product){
    _cartCache ??= [];
    for(var purchase in _cartCache!){
      if(purchase.product.name == product.name){
        purchase.amount++;
        return;
      }
    }
    _cartCache!.add(Purchase(1, product));
  }

  void removePurchaseFromCache(Product product){
    _cartCache ??= [];
    for(var purchase in _cartCache!){
      if(purchase.product.name == product.name){
        purchase.amount--;
        if(purchase.amount < 1){
          _cartCache!.remove(purchase);
        }
        return;
      }
    }
  }

  Future<void> addPurchase(Product product) async{
    await APIEmulator.addPurchase(product);
  }

  Future<void> removePurchase(Product product) async{
    await APIEmulator.removePurchase(product);
  }

  // The way, how this works may seem sad and anti-patternestic,
  // but I don't know, how to do it better

  Future<bool> updateCartCache() async{
    _cartCache ??= [];
    bool flag = true;
    var cart = await APIEmulator.getPurchases();
    if(_cartCache!.length != cart.length) flag = false;

    for(int i = 0; i < cart.length; i++){
      if(_cartCache![i].amount != cart[i].amount || _cartCache![i].product.name != cart[i].product.name) {
        flag = false;
        break;
      }
    }

    // Actually we update cache only when all requests are sent
    if(canUpdateCartCache()){
      _cartCache = cart;
    }

    return flag;
  }
}