// lib/data/mappers/category_mapper.dart
import '../../../../core/models/category.dart';
// import '../../domain/entities/category.dart';
import '../dto/category_dto.dart';
// import '../dtos/category_dto.dart';

class CategoryMapper {
  static Category toDomain(CategoryDto dto) {
    return Category(
      id: dto.id,
      name: dto.name,
      // Ignore imageUrl and productCount as per domain requirements
    );
  }

  static CategoryDto toDto(Category category) {
    return CategoryDto(
      id: category.id,
      name: category.name,
      // imageUrl and productCount are null for DTO creation
    );
  }
}