


import 'package:json_annotation/json_annotation.dart';

part 'product2_dto.g.dart';

@JsonSerializable()
class Product2Dto {
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

  Product2Dto({
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

  factory Product2Dto.fromJson(Map<String, dynamic> json) =>
      _$Product2DtoFromJson(json);

  Map<String, dynamic> toJson() => _$Product2DtoToJson(this);
}