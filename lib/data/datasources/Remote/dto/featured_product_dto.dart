import 'package:json_annotation/json_annotation.dart';

part 'featured_product_dto.g.dart';

@JsonSerializable()
class FeaturedProductDto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;


  FeaturedProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,

  });

  factory FeaturedProductDto.fromJson(Map<String, dynamic> json) =>
      _$FeaturedProductDtoFromJson(json);
}

