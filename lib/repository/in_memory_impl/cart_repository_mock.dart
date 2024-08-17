import 'dart:math';

import 'package:antons_app/entities/product.dart';
import 'package:antons_app/repository/cart_repository.dart';
import 'package:flutter/cupertino.dart';

class CartRepositoryMock implements CartRepository{
  final Random random = Random();
  final List<Product> _cart =
  [
    Product('index1', 'Рыба', 2, 100, 0, 'Очень вкусная рыба. Пальчики оближешь!', 'Имбулечка', null, null, null, null, null, null, null, null, null),
  ];

  @override
  Future<List<Product>> getCart() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Product> newList = [];
    for(var product in _cart){
      newList.add(Product.clone(product));
    }
    return newList;
  }

  @override
  Future<void> addProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    if(random.nextInt(10) < 8){
      for(var cartProduct in _cart){
        if(cartProduct.id == product.id){
          debugPrint("amount increased");
          cartProduct.quantity++;
          return;
        }
      }
      debugPrint("new added");
      Product clone = Product.clone(product);
      clone.quantity = 1;
      _cart.add(clone);
    }
  }

  @override
  Future<void> removeProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    for(var cartProduct in _cart){
      if(cartProduct.id == product.id){
        cartProduct.quantity--;
        if(cartProduct.quantity < 1){
          _cart.remove(cartProduct);
        }
        return;
      }
    }
  }

  @override
  Future<bool> order() async{
    await Future.delayed(const Duration(seconds: 1));
    _cart.clear();
    return true;
  }

}