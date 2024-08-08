// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleProductResponse _$SingleProductResponseFromJson(
        Map<String, dynamic> json) =>
    SingleProductResponse(
      json['productId'] as String,
      json['productName'] as String,
      (json['quantity'] as num).toInt(),
      (json['price'] as num).toDouble(),
      (json['discount'] as num?)?.toDouble(),
      json['description'] as String?,
      json['shortDescription'] as String?,
      (json['mass'] as num?)?.toDouble(),
      (json['kkal'] as num?)?.toDouble(),
      (json['belki'] as num?)?.toDouble(),
      (json['jiri'] as num?)?.toDouble(),
      (json['uglevodi'] as num?)?.toDouble(),
      (json['shelfLife'] as num?)?.toDouble(),
      json['condtionsLife'] as String?,
      json['companyName'] as String?,
      json['imgURL'] as String?,
    );

Map<String, dynamic> _$SingleProductResponseToJson(
        SingleProductResponse instance) =>
    <String, dynamic>{
      'productId': instance.id,
      'productName': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'discount': instance.discount,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'mass': instance.weight,
      'kkal': instance.kkal,
      'belki': instance.proteins,
      'jiri': instance.fats,
      'uglevodi': instance.carbohydrates,
      'shelfLife': instance.shelfLife,
      'condtionsLife': instance.conditionsLife,
      'companyName': instance.companyName,
      'imgURL': instance.imageUrl,
    };
