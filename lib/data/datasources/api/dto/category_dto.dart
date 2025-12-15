// lib/data/dtos/category_dto.dart

class CategoryDto {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;
  final int productCount;

  CategoryDto({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.productCount = 0,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? json['image'],
      description: json['description'],
      productCount: json['productCount'] ?? json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'productCount': productCount,
    };
  }
}