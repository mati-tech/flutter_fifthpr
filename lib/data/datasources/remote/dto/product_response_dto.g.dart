// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponseDto _$ProductsResponseDtoFromJson(Map<String, dynamic> json) =>
    ProductsResponseDto(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsResponseDtoToJson(
        ProductsResponseDto instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
    };
