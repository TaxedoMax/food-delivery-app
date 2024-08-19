import 'package:antons_app/dto/single_product_response.dart';

class Product{
  final String id;
  final String name;
  int amountInCart = 0;
  final int amountInStore;
  final double price;
  final double? discount;
  final String? description;
  final String? shortDescription;
  final double? weight;
  final double? kkal;
  final double? proteins;
  final double? fats;
  final double? carbohydrates;
  final double? shelfLife;
  final String? conditionsLife;
  final String? companyName;
  final String? imageUrl;

  bool canBeAddedToCart() => amountInCart < amountInStore;

  Product.named({required this.id, required this.name, required this.amountInCart, required this.amountInStore, required this.price, required this.discount, required this.description, required this.shortDescription, required this.weight, required this.kkal, required this.proteins, required this.fats, required this.carbohydrates, required this.shelfLife, required this.conditionsLife, required this.companyName, required this.imageUrl});
  Product(this.id, this.name, this.amountInCart, this.amountInStore, this.price, this.discount, this.description, this.shortDescription, this.weight, this.kkal, this.proteins, this.fats, this.carbohydrates, this.shelfLife, this.conditionsLife, this.companyName, this.imageUrl);
  factory Product.fromSingleProductResponse(SingleProductResponse singleProductResponse) => Product(
      singleProductResponse.id,
      singleProductResponse.name,
      0,
      singleProductResponse.quantity,
      singleProductResponse.price,
      singleProductResponse.discount,
      singleProductResponse.description,
      singleProductResponse.shortDescription,
      singleProductResponse.weight,
      singleProductResponse.kkal,
      singleProductResponse.proteins,
      singleProductResponse.fats,
      singleProductResponse.carbohydrates,
      singleProductResponse.shelfLife,
      singleProductResponse.conditionsLife,
      singleProductResponse.companyName,
      singleProductResponse.imageUrl
  );
  factory Product.clone(Product product) => Product(
      product.id,
      product.name,
      product.amountInCart,
      product.amountInStore,
      product.price,
      product.discount,
      product.description,
      product.shortDescription,
      product.weight,
      product.kkal,
      product.proteins,
      product.fats,
      product.carbohydrates,
      product.shelfLife,
      product.conditionsLife,
      product.companyName,
      product.imageUrl
  );

  static List<Product> cloneList(List<Product> products){
    List<Product> cloneList = [];
    for(var product in products){
      cloneList.add(Product.clone(product));
    }
    return cloneList;
  }
}