import 'models/group_model.dart';

class InMemoryDB{
  static List<Group> groupsList = [
    Group(name: 'Готовая еда', imageUrl: '', subGroups: ['Завтрак, обед и ужин', 'Перекус', 'Всё горячее', 'Десерты и выпечка', 'Горячий кофе']),
    Group(name: 'Mолоко, яйца и сыр', imageUrl: '', subGroups: ['Молочное и яйца', 'Йогурты и десерты', 'Cыр']),
    Group(name: 'Овощи, грибы и фрукты', imageUrl: '', subGroups: ['Овощи', 'Грибы', 'Фрукты', 'Зелень']),
  ];
}