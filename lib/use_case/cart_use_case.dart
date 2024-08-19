import 'dart:core';
import 'package:antons_app/entities/product.dart';
import 'package:antons_app/repository/cart_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class CartUseCase{

  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  List<Product>? _cartCache;

  Future<List<Product>> getCart() async {
    _cartCache = await _cartRepository.getCart();
    return _cartCache!;
  }

  List<Product> getCartCache(){
    _cartCache ??= [];
    return _cartCache!;
  }

  Future<void> addProduct(Product product) async {
    _cartCache ??= [];
    await _cartRepository.addProduct(product);
  }

  Future<void> removeProduct(Product product) async {
    _cartCache ??= [];
    await _cartRepository.removeProduct(product);
  }

  // TODO: Make normal function without multiple values
  (List<int>, List<Product>) cartsDifference(List<Product> oldCart, List<Product> newCart){
    List<Product> changedProducts = [];
    List<int> changeDelta = [];

    List<int> foundIndexes = [];

    // Checking removed or changed products
    for(var oldProduct in oldCart){
      int newCartIndex = newCart.indexWhere((product) => product.id == oldProduct.id);
      if(newCartIndex == -1){
        changedProducts.add(oldProduct);
        changeDelta.add(-1 * oldProduct.amountInCart);
      }
      else{
        foundIndexes.add(newCartIndex);

        int delta = newCart[newCartIndex].amountInCart - oldProduct.amountInCart;
        if(delta != 0){
          changedProducts.add(oldProduct);
          changeDelta.add(delta);
        }
      }
    }

    // Checking new products
    for(int i = 0; i < newCart.length; i++){
      if(!foundIndexes.contains(i)){
        changeDelta.add(newCart[i].amountInCart);
        changedProducts.add(newCart[i]);
      }
    }

    return (changeDelta, changedProducts);
  }

  clearCache(){
    _cartCache = null;
  }

  Future<bool> order() async{
    bool status = await _cartRepository.order();
    return status;
  }
}