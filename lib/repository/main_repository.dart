import 'dart:core';

import 'package:antons_app/models/product_model.dart';
import 'package:antons_app/repository/api_emulator.dart';
import 'package:flutter/cupertino.dart';

import '../models/group_model.dart';
import '../models/purchase_model.dart';

class MainRepository{
  static List<Group>? _groupsCache;
  static Map<String, List<Product>>? _productsCache;
  static List<Purchase>? _basketCache;

  // This var, and all methods with it is necessary to understand,
  // when we can check if basket in cache and actual basket are same,
  // and there are no mistakes. If we check after every operation,
  // either amount of products will change
  // from one value to another, or buttons will freeze.
  static int _runningBasketUpdateRequests = 0;

  static bool canUpdateBasketCache(){
    return _runningBasketUpdateRequests == 0;
  }

  static void basketUpdateRequestStarted(){
    _runningBasketUpdateRequests++;
  }

  static void basketUpdateRequestFinished(){
    _runningBasketUpdateRequests--;
  }

  static Future<List<Group>> getGroupList () async {
    _groupsCache ??= await APIEmulator.getGroups();
    return _groupsCache!;
  }

  static Future<List<Product>> getProductByGroupName(String groupName) async {
    _productsCache ??= {};
    if(!_productsCache!.containsKey(groupName)){
      _productsCache![groupName] = await APIEmulator.getProducts(groupName);
    }

    return _productsCache![groupName]!;
  }

  static Future<List<Purchase>> getPurchases() async{
    _basketCache ??= await APIEmulator.getPurchases();
    return _basketCache!;
  }

  static List<Purchase> getPurchaseFromCache(){
    return _basketCache ?? [];
  }

  static void addPurchaseToCache(Product product){
    _basketCache ??= [];
    for(var purchase in _basketCache!){
      if(purchase.product.name == product.name){
        purchase.amount++;
        return;
      }
    }
    _basketCache!.add(Purchase(1, product));
  }

  static Future<void> addPurchase(Product product) async{
    await APIEmulator.addPurchase(product);
  }

  // The way, how this works may seem sad and anti-patternestic,
  // but I don't know, how to do it better

  static Future<bool> updateBasketCache() async{
    _basketCache ??= [];
    bool flag = true;
    var basket = await APIEmulator.getPurchases();
    if(_basketCache!.length != basket.length) flag = false;

    for(int i = 0; i < basket.length; i++){
      if(_basketCache![i].amount != basket[i].amount || _basketCache![i].product.name != basket[i].product.name) {
        flag = false;
        break;
      }
    }

    // Actually we update cache only when all requests are sent
    if(canUpdateBasketCache()){
      _basketCache = basket;
    }

    return flag;
  }
}