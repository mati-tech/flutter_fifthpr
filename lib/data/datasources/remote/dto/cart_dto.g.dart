// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProductDto _$CartProductDtoFromJson(Map<String, dynamic> json) =>
    CartProductDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      total: (json['total'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      discountedTotal: (json['discountedTotal'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$CartProductDtoToJson(CartProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
      'discountPercentage': instance.discountPercentage,
      'discountedTotal': instance.discountedTotal,
      'thumbnail': instance.thumbnail,
    };

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
      id: (json['id'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      discountedTotal: (json['discountedTotal'] as num).toDouble(),
      userId: (json['userId'] as num).toInt(),
      totalProducts: (json['totalProducts'] as num).toInt(),
      totalQuantity: (json['totalQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'total': instance.total,
      'discountedTotal': instance.discountedTotal,
      'userId': instance.userId,
      'totalProducts': instance.totalProducts,
      'totalQuantity': instance.totalQuantity,
    };

CartResponseDto _$CartResponseDtoFromJson(Map<String, dynamic> json) =>
    CartResponseDto(
      carts: (json['carts'] as List<dynamic>)
          .map((e) => CartDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$CartResponseDtoToJson(CartResponseDto instance) =>
    <String, dynamic>{
      'carts': instance.carts,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
