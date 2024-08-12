import 'package:antons_app/repository/category_repository.dart';
import 'package:get_it/get_it.dart';

import '../entities/category.dart';

class CategoryUseCase{
  List<Category>? _categoriesCache;
  final CategoryRepository _categoryRepository = GetIt.I.get<CategoryRepository>();

  Future<List<Category>> getCategoryList () async {
    _categoriesCache ??= await _categoryRepository.getCategories();
    return _categoriesCache!;
  }

  void clearCache(){
    _categoriesCache = null;
  }
}