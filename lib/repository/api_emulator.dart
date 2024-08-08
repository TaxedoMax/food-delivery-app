import 'package:flutter/cupertino.dart';
import 'package:pair/pair.dart';

import '../entities/category.dart';
import '../entities/product.dart';

class APIEmulator{
  static final List<Category> _categoryList =
  [
    Category(id: '1', name: 'Готовая еда', imageUrl: 'https://cm.samokat.ru/processed/l/product_card/01099c85-859a-481f-a53b-01e728fa7706.jpg',
        subCategories:
          [
            Category(id: '11', name: 'Завтрак, обед и ужин', imageUrl: '', subCategories: []),
            Category(id: '12', name: 'Перекус', imageUrl: '', subCategories: []),
            Category(id: '13', name: 'Всё горячее', imageUrl: '', subCategories: []),
            Category(id: '14', name: 'Десерты и выпечка', imageUrl: '', subCategories: []),
            Category(id: '15', name: 'Горячий кофе', imageUrl: '', subCategories: []),
          ]
    ),
    Category(id: '2', name: 'Mолоко, яйца и сыр', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg',
        subCategories:
          [
            Category(id: '21', name: 'Молочное и яйца', imageUrl: '', subCategories: []),
            Category(id: '22', name: 'Йогурты и десерты', imageUrl: '', subCategories: []),
            Category(id: '23', name: 'Cыр', imageUrl: '', subCategories: []),
          ]
    ),
    Category(id: '3', name: 'Овощи, грибы и фрукты', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg',
        subCategories:
          [
            Category(id: '31', name: 'Овощи', imageUrl: '', subCategories: []),
            Category(id: '32', name: 'Грибы', imageUrl: '', subCategories: []),
            Category(id: '33', name: 'Фрукты', imageUrl: '', subCategories: []),
            Category(id: '34', name: 'Зелень', imageUrl: '', subCategories: []),
          ]
    ),
  ];

  static Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Category> newList = [];
    for(var category in _categoryList){
      newList.add(Category(id: category.id, name: category.name, imageUrl: category.imageUrl, subCategories: category.subCategories));
    }
    return newList;
  }

  static final Map<String, List<Product>> _products = {
    '11': [
      Product('index1', 'Рыба', 10, 100, 0, 'Очень вкусная рыба. Пальчики оближешь!', 'Имбулечка', null, null, null, null, null, null, null, null, null),
      Product.named(id: 'spb', name: 'Санкт-Петербург', quantity: 1, price: 52, discount: 0, description: 'Тем больше нравится Москва', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
      Product.named(id: 'msk', name: 'Москва', quantity: 1, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
      Product.named(id: 'grechka', name: 'Гречка', quantity: 30, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: 'https://besarte.ru/wp-content/uploads/2023/04/chem-polezna-grechka-dlya-organizma-cheloveka.jpg'),
      Product.named(id: 'vatrushka', name: 'Ватрушка', quantity: 30, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
    ],
    '21' : [
      Product.named(id: 'vatrushka', name: 'Молочное', quantity: 3, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
      Product.named(id: 'spb', name: 'Санкт-Петербург', quantity: 1, price: 52, discount: 0, description: 'Тем больше нравится Москва', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null)
    ]
  };

  static Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    await Future.delayed(const Duration(seconds: 1));

    if(_products.containsKey(categoryId)){
      List<Product> newList = [];
      for(var product in _products[categoryId]!){
        newList.add(Product.clone(product));
      }
      return newList;
    }
    else {
      return [];
    }
  }

  static final List<Product> _cart =
  [
    Product('index1', 'Рыба', 2, 100, 0, 'Очень вкусная рыба. Пальчики оближешь!', 'Имбулечка', null, null, null, null, null, null, null, null, null),
  ];

  static Future<List<Product>> getCart() async{
    await Future.delayed(const Duration(seconds: 1));
    List<Product> newList = [];
    for(var product in _cart){
      newList.add(Product.clone(product));
    }
    return newList;
  }

  static Future<void> addProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    for(var cartProduct in _cart){
      if(cartProduct.id == product.id){
        debugPrint("amount increased");
        cartProduct.quantity++;
        return;
      }
    }
    debugPrint("new added");
    _cart.add(Product.clone(product));
  }

  static Future<void> removeProduct(Product product) async {
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

  static final List<Pair<String, String>> _users =
  [
    const Pair('admin', 'admin'),
    const Pair('max', '123456')
  ];

  static Future<String> register(String login, String email, String password) async{
    await Future.delayed(const Duration(seconds: 1));
    for(var pair in _users){
      if(pair.key == login) return 'Login exist';
    }
    _users.add(Pair(login, password));
    return 'OK';
  }

  static Future<String> signIn(String login, String password) async{
    await Future.delayed(const Duration(seconds: 1));
    var credentials = Pair(login, password);

    if(_users.contains(credentials)){
      return 'OK';
    }
    return 'ERROR';
  }

}