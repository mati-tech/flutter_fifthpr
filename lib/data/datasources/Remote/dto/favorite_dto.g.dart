// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDto _$FavoriteDtoFromJson(Map<String, dynamic> json) => FavoriteDto(
      id: (json['id'] as num).toInt(),
      user_id: (json['user_id'] as num).toInt(),
      product_id: (json['product_id'] as num).toInt(),
    );

Map<String, dynamic> _$FavoriteDtoToJson(FavoriteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'product_id': instance.product_id,
    };
