import 'package:json_annotation/json_annotation.dart';

part 'fakestore_product_dto.g.dart';

@JsonSerializable()
class FakeStoreProductDto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  FakeStoreProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory FakeStoreProductDto.fromJson(Map<String, dynamic> json) =>
      _$FakeStoreProductDtoFromJson(json);
}
