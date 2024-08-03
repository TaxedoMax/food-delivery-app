import '../models/product_model.dart';
import '../repository/api_emulator.dart';

class ProductListUseCase{
  Map<String, List<Product>>? _productsCache;

  Future<List<Product>> getProductByCategoryName(String groupName) async {
    _productsCache ??= {};
    if(!_productsCache!.containsKey(groupName)){
      _productsCache![groupName] = await APIEmulator.getProducts(groupName);
    }

    return _productsCache![groupName]!;
  }
}