
import 'package:antons_app/models/product_model.dart';

import 'models/group_model.dart';

class InMemoryDB{
  static List<Group> groupsList = [
    Group(name: 'Готовая еда', imageUrl: 'https://cm.samokat.ru/processed/l/product_card/01099c85-859a-481f-a53b-01e728fa7706.jpg', subGroups: ['Завтрак, обед и ужин', 'Перекус', 'Всё горячее', 'Десерты и выпечка', 'Горячий кофе']),
    Group(name: 'Mолоко, яйца и сыр', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg', subGroups: ['Молочное и яйца', 'Йогурты и десерты', 'Cыр']),
    Group(name: 'Овощи, грибы и фрукты', imageUrl: 'https://static21.tgcnt.ru/posts/_0/e1/e1b6cfc149cd7de1a38ca63ef1ab2d43.jpg', subGroups: ['Овощи', 'Грибы', 'Фрукты', 'Зелень']),
  ];

  static Map<String, List<Product>> products = {
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
}