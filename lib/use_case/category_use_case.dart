import 'package:antons_app/repository/category_repository.dart';

import '../entities/category.dart';
import '../repository/api_emulator.dart';

class CategoryUseCase{
  List<Category>? _categoriesCache;
  var categoryRepository = CategoryRepository();

  Future<List<Category>> getCategoryList () async {
    _categoriesCache ??= await categoryRepository.getCategories();
    return _categoriesCache!;
  }

  void clearCache(){
    _categoriesCache = null;
  }
}