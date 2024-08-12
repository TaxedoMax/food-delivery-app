import '../entities/product.dart';

abstract class ProductsRepository{
  Future<List<Product>> getProductsByCategoryId(String id);
}