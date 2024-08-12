import '../entities/product.dart';

abstract class CartRepository{
  Future<List<Product>> getCart();
  Future<void> addProduct(Product product);
  Future<void> removeProduct(Product product);
  Future<bool> order();
}