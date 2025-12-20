// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product2_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product2Dto _$Product2DtoFromJson(Map<String, dynamic> json) => Product2Dto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      brand: json['brand'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$Product2DtoToJson(Product2Dto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'brand': instance.brand,
      'images': instance.images,
    };
