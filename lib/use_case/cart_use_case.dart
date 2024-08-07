import 'dart:core';

import 'package:antons_app/entities/product.dart';
import 'package:antons_app/repository/api_emulator.dart';
import 'package:antons_app/repository/cart_repository.dart';

class CartUseCase{
  CartRepository _cartRepository = CartRepository();
  List<Product>? _cartCache;

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


  Future<List<Product>> getCart() async{
    _cartCache ??= await _cartRepository.getCart();
    return _cartCache!;
  }

  List<Product> getPurchaseFromCache(){
    return _cartCache ?? [];
  }

  void addProductToCache(Product product){
    _cartCache ??= [];
    for(var cartProduct in _cartCache!){
      if(cartProduct.id == product.id){
        cartProduct.quantity++;
        return;
      }
    }
    var newProduct = Product.clone(product);
    newProduct.quantity = 1;
    _cartCache!.add(newProduct);
  }

  void removeProductFromCache(Product product){
    _cartCache ??= [];
    for(var cartProduct in _cartCache!){
      if(cartProduct.id == product.id){
        cartProduct.quantity--;
        if(cartProduct.quantity < 1){
          _cartCache!.remove(cartProduct);
        }
        return;
      }
    }
  }

  void clearCache(){
    _cartCache = null;
  }

  Future<void> addProduct(Product product) async{
    await _cartRepository.addProduct(product);
  }

  Future<void> removeProduct(Product product) async{
    await _cartRepository.removeProduct(product);
  }

  Future<bool> order() async{
    bool status = await _cartRepository.order();
    return status;
  }

  // The way, how this works may seem sad and anti-patternestic,
  // but I don't know, how to do it better

  Future<bool> updateCartCache() async{
    _cartCache ??= [];
    bool flag = true;
    var cart = await _cartRepository.getCart();
    if(_cartCache!.length != cart.length) flag = false;

    for(int i = 0; i < cart.length; i++){
      if(_cartCache![i].quantity != cart[i].quantity || _cartCache![i].id != cart[i].id) {
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