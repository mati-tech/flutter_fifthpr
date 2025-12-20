import 'package:json_annotation/json_annotation.dart';

part 'product_detail_dto.g.dart';

@JsonSerializable()
class ProductDetailDto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  ProductDetailDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDtoFromJson(json);
}

