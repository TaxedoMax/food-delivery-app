// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleCategoryResponse _$SingleCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    SingleCategoryResponse(
      json['categoryId'] as String,
      json['categoryName'] as String,
      json['upperCategoryName'] as String?,
      json['imgURL'] as String,
    );

Map<String, dynamic> _$SingleCategoryResponseToJson(
        SingleCategoryResponse instance) =>
    <String, dynamic>{
      'categoryId': instance.id,
      'categoryName': instance.name,
      'upperCategoryName': instance.upperCategoryName,
      'imgURL': instance.imageUrl,
    };
