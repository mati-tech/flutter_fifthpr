import 'package:json_annotation/json_annotation.dart';

part 'favorite_dto.g.dart';

@JsonSerializable()
class FavoriteDto {
  final int id;
  final int user_id;
  final int product_id;

  FavoriteDto({
    required this.id,
    required this.user_id,
    required this.product_id,
  });

  factory FavoriteDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDtoFromJson(json);
}
