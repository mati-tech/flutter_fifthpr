import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final int id;
  final String title;
  final String description;
  final double price;
  @JsonKey(name: 'discountPercentage')
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final List<String> images;

  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.images,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}