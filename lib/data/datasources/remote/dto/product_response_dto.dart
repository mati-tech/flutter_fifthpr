import 'package:json_annotation/json_annotation.dart';
import 'product_dto.dart';

part 'product_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsResponseDto {
  final List<ProductDto> products;

  ProductsResponseDto({required this.products});

  factory ProductsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseDtoToJson(this);
}
