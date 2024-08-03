import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/purchase_model.dart';

class APIEmulator{
  static final List<Category> _categoryList =
  [
    Category(name: 'Готовая еда', imageUrl: 'https://cm.samokat.ru/processed/l/product_card/01099c85-859a-481f-a53b-01e728fa7706.jpg', subCategories: ['Завтрак, обед и ужин', 'Перекус', 'Всё горячее', 'Десерты и выпечка', 'Горячий кофе']),
    Category(name: 'Mолоко, яйца и сыр', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg', subCategories: ['Молочное и яйца', 'Йогурты и десерты', 'Cыр']),
    Category(name: 'Овощи, грибы и фрукты', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg', subCategories: ['Овощи', 'Грибы', 'Фрукты', 'Зелень']),
  ];

  static Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Category> newList = [];
    for(var category in _categoryList){
      newList.add(Category(name: category.name, imageUrl: category.imageUrl, subCategories: category.subCategories));
    }
    return newList;
  }

  static final Map<String, List<Product>> _products = {
    'Завтрак, обед и ужин': [
      Product(name: 'Овсянка', price: 100, weight: 15, imageUrl: ''),
      Product(name: 'Гречка', price: 150, weight: 20, imageUrl: 'https://besarte.ru/wp-content/uploads/2023/04/chem-polezna-grechka-dlya-organizma-cheloveka.jpg'),
      Product(name: 'Рис', price: 190, weight: 1000, imageUrl: ''),
      Product(name: 'Панкейки с вишней', price: 1000, weight: 150, imageUrl: ''),
      Product(name: 'Йогурт', price: 2000, weight: 100, imageUrl: '')
    ],
    'Молочное и яйца' : [
      Product(name: 'Молочное', price: 100, weight: 15, imageUrl: 'https://cm.samokat.ru/processed/l/product_card/01099c85-859a-481f-a53b-01e728fa7706.jpg'),
      Product(name: 'Яйца', price: 100, weight: 15, imageUrl: '')
    ]
  };

  static Future<List<Product>> getProducts(String categoryName) async {
    await Future.delayed(const Duration(seconds: 1));

    if(_products.containsKey(categoryName)){
      List<Product> newList = [];
      for(var product in _products[categoryName]!){
        newList.add(Product(name: product.name, price: product.price, weight: product.weight, imageUrl: product.imageUrl));
      }
      return newList;
    }
    else {
      return [];
    }
  }

  static final List<Purchase> _cart =
  [
    Purchase(2, Product(name: "Рис", price: 100, weight: 20, imageUrl: '')),
    Purchase(3, Product(name: "Cыр", price: 10, weight: 30, imageUrl: '')),
    Purchase(1, Product(name: "Масло", price: 10000, weight: 1000, imageUrl: ''))
  ];

  static Future<List<Purchase>> getPurchases() async{
    await Future.delayed(const Duration(seconds: 1));
    List<Purchase> newList = [];
    for(var purchase in _cart){
      newList.add(Purchase(purchase.amount, purchase.product));
    }
    return newList;
  }

  static Future<void> addPurchase(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    for(var purchase in _cart){
      if(purchase.product.name == product.name){
        debugPrint("amount increased");
        purchase.amount++;
        return;
      }
    }
    debugPrint("new added");
    _cart.add(Purchase(1, product));
  }

  static Future<void> removePurchase(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    for(var purchase in _cart){
      if(purchase.product.name == product.name){
        purchase.amount--;
        if(purchase.amount < 1){
          _cart.remove(purchase);
        }
        return;
      }
    }
  }

}