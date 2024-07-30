import 'package:flutter/cupertino.dart';

import '../models/group_model.dart';
import '../models/product_model.dart';
import '../models/purchase_model.dart';

class APIEmulator{
  static final List<Group> _groupsList =
  [
    Group(name: 'Готовая еда', imageUrl: 'https://cm.samokat.ru/processed/l/product_card/01099c85-859a-481f-a53b-01e728fa7706.jpg', subGroups: ['Завтрак, обед и ужин', 'Перекус', 'Всё горячее', 'Десерты и выпечка', 'Горячий кофе']),
    Group(name: 'Mолоко, яйца и сыр', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg', subGroups: ['Молочное и яйца', 'Йогурты и десерты', 'Cыр']),
    Group(name: 'Овощи, грибы и фрукты', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg', subGroups: ['Овощи', 'Грибы', 'Фрукты', 'Зелень']),
  ];

  static Future<List<Group>> getGroups() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Group> newList = [];
    for(var group in _groupsList){
      newList.add(Group(name: group.name, imageUrl: group.imageUrl, subGroups: group.subGroups));
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

  static Future<List<Product>> getProducts(String groupName) async {
    await Future.delayed(const Duration(seconds: 1));

    if(_products.containsKey(groupName)){
      List<Product> newList = [];
      for(var product in _products[groupName]!){
        newList.add(Product(name: product.name, price: product.price, weight: product.weight, imageUrl: product.imageUrl));
      }
      return newList;
    }
    else {
      return [];
    }
  }

  static final List<Purchase> _basket =
  [
    Purchase(2, Product(name: "Рис", price: 100, weight: 20, imageUrl: '')),
    Purchase(3, Product(name: "Cыр", price: 10, weight: 30, imageUrl: '')),
    Purchase(1, Product(name: "Масло", price: 10000, weight: 1000, imageUrl: ''))
  ];

  static Future<List<Purchase>> getPurchases() async{
    await Future.delayed(const Duration(seconds: 1));
    List<Purchase> newList = [];
    for(var purchase in _basket){
      newList.add(Purchase(purchase.amount, purchase.product));
    }
    return newList;
  }

  static Future<void> addPurchase(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    for(var purchase in _basket){
      if(purchase.product.name == product.name){
        debugPrint("amount increased");
        purchase.amount++;
        return;
      }
    }
    debugPrint("new added");
    _basket.add(Purchase(1, product));
  }

}