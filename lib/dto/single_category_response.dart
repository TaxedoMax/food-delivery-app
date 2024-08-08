import 'package:json_annotation/json_annotation.dart';

part 'single_category_response.g.dart';

@JsonSerializable()
class SingleCategoryResponse{
  @JsonKey(name: 'categoryId')
  final String id;

  @JsonKey(name: 'categoryName')
  final String name;

  @JsonKey(name: 'upperCategoryName')
  final String? upperCategoryName;

  @JsonKey(name: 'imgURL')
  final String imageUrl;

  SingleCategoryResponse(this.id, this.name, this.upperCategoryName, this.imageUrl);

  factory SingleCategoryResponse.fromJson(Map<String, dynamic> json) => _$SingleCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleCategoryResponseToJson(this);
}