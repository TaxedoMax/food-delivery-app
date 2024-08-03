import '../models/category_model.dart';
import '../repository/api_emulator.dart';

class CategoryUseCase{
  List<Category>? _categoriesCache;

  Future<List<Category>> getCategoryList () async {
    _categoriesCache ??= await APIEmulator.getCategories();
    return _categoriesCache!;
  }

}