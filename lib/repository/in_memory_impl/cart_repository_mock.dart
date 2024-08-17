import 'dart:math';

import 'package:antons_app/entities/product.dart';
import 'package:antons_app/repository/cart_repository.dart';
import 'package:flutter/cupertino.dart';

class CartRepositoryMock implements CartRepository{
  final Random random = Random();
  final List<Product> _cart =
  [
    Product.named(id: 'index1', name: 'Рыбка', amountInCart: 2, amountInStore: 3, price: 100, discount: 0, description: null, shortDescription: null, weight: null, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: ''),
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
    if(true){
      for(var cartProduct in _cart){
        if(cartProduct.id == product.id){
          cartProduct.amountInCart++;
          return;
        }
      }
      Product clone = Product.clone(product);
      clone.amountInCart = 1;
      _cart.add(clone);
    }
  }

  @override
  Future<void> removeProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    for(var cartProduct in _cart){
      if(cartProduct.id == product.id){
        cartProduct.amountInCart--;
        if(cartProduct.amountInCart < 1){
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