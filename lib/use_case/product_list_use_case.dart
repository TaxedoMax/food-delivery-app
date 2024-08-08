import 'package:antons_app/repository/products_repository.dart';

import '../entities/product.dart';
import '../repository/api_emulator.dart';

class ProductListUseCase{
  final _productsRepository = ProductsRepository();
  Map<String, List<Product>>? _productsCache;

  Future<List<Product>> getProductByCategoryId(String id) async {
    _productsCache ??= {};
    if(!_productsCache!.containsKey(id)){
      _productsCache![id] = await _productsRepository.getProductsByCategoryId(id);
    }

    return _productsCache![id]!;
  }

  void removeCategoryFromCacheById(String id){
    if(_productsCache != null){
      _productsCache!.removeWhere((key, value) => key == id);
    }
  }

  void clearCache(){
    _productsCache = null;
  }
}