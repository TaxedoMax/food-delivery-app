import 'package:antons_app/repository/category_repository.dart';

import '../../entities/category.dart';

class CategoryRepositoryMock implements CategoryRepository{
  final List<Category> _categoryList =
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
    Category(id: '4', name: 'Banana', imageUrl: '', subCategories: []),
  ];

  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Category> newList = [];
    for(var category in _categoryList){
      newList.add(Category(id: category.id, name: category.name, imageUrl: category.imageUrl, subCategories: category.subCategories));
    }
    return newList;
  }
}