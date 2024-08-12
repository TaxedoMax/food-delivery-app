import 'package:antons_app/repository/products_repository.dart';
import 'package:get_it/get_it.dart';

import '../entities/product.dart';

class ProductListUseCase{
  final ProductsRepository _productsRepository = GetIt.I.get<ProductsRepository>();
  Map<String, List<Product>>? _productsCache;

  Future<List<Product>> getProductsByCategoryId(String id) async {
    _productsCache ??= {};
    if(!_productsCache!.containsKey(id)){
      _productsCache![id] = await _productsRepository.getProductsByCategoryId(id);
    }

    return _productsCache![id]!;
  }

  Product? getProductFromCacheById(String id){
    if(_productsCache == null) {
      return null;
    }

    else {
      Product? result;
      _productsCache!.forEach((key, value) {
        for(Product product in value){
          if(product.id == id){
            result = product;
            return;
          }
        }
      });

      return result;
    }
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