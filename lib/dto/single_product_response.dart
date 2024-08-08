import 'package:json_annotation/json_annotation.dart';
part 'single_product_response.g.dart';

@JsonSerializable()
class SingleProductResponse{
  @JsonKey(name: 'productId')
  final String id;
  @JsonKey(name: 'productName')
  final String name;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'discount')
  final double? discount;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'shortDescription')
  final String? shortDescription;
  @JsonKey(name: 'mass')
  final double? weight;
  @JsonKey(name: 'kkal')
  final double? kkal;
  @JsonKey(name: 'belki')
  final double? proteins;
  @JsonKey(name: 'jiri')
  final double? fats;
  @JsonKey(name: 'uglevodi')
  final double? carbohydrates;
  @JsonKey(name: 'shelfLife')
  final double? shelfLife;
  @JsonKey(name: 'condtionsLife')
  final String? conditionsLife;
  @JsonKey(name: 'companyName')
  final String? companyName;
  @JsonKey(name: 'imgURL')
  final String? imageUrl;

  SingleProductResponse(this.id, this.name, this.quantity, this.price, this.discount, this.description, this.shortDescription, this.weight, this.kkal, this.proteins, this.fats, this.carbohydrates, this.shelfLife, this.conditionsLife, this.companyName, this.imageUrl);

  factory SingleProductResponse.fromJson(Map<String, dynamic> json) => _$SingleProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleProductResponseToJson(this);
}