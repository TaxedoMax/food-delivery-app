import 'package:antons_app/repository/products_repository.dart';

import '../../entities/product.dart';

class ProductsRepositoryMock implements ProductsRepository{
  final Map<String, List<Product>> _products = {
    '11': [
      Product.named(id: 'index1', name: 'Рыбка', amountInCart: 0, amountInStore: 3, price: 100, discount: 0, description: null, shortDescription: null, weight: null, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: ''),
      Product.named(id: 'spb', name: 'Санкт-Петербург', amountInCart: 0, amountInStore: 1, price: 52, discount: 0, description: 'Тем больше нравится Москва', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
      Product.named(id: 'msk', name: 'Москва', amountInCart: 0, amountInStore: 1, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
      Product.named(id: 'grechka', name: 'Гречка', amountInCart: 0, amountInStore: 30, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: 'https://besarte.ru/wp-content/uploads/2023/04/chem-polezna-grechka-dlya-organizma-cheloveka.jpg'),
      Product.named(id: 'vatrushka', name: 'Ватрушка', amountInCart: 0, amountInStore: 30, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
    ],
    '21' : [
      Product.named(id: 'vatrushka', name: 'Молочное', amountInCart: 0, amountInStore: 3, price: 100, discount: 0, description: 'Но в Питере семья', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: null),
      Product.named(id: 'spb', name: 'Санкт-Петербург', amountInCart: 0, amountInStore: 1, price: 52, discount: 0, description: 'Тем больше нравится Москва', shortDescription: 'Пиьясят два', weight: 52, kkal: null, proteins: null, fats: null, carbohydrates: null, shelfLife: null, conditionsLife: null, companyName: null, imageUrl: 'https://cm.samokat.ru/processed/l/product_card/b48dcacd-64a3-403a-b7d9-e92efbe41813.jpg')
    ]
  };

  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
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
}