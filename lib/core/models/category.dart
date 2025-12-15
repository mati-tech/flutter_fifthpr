// /// Domain entity representing a product category
// /// Pure Dart class - no Flutter dependencies
// class Category {
//   final String id;
//   final String name;
//   final String? description;
//   final String? imageUrl;
//
//   Category({
//     required this.id,
//     required this.name,
//     this.description,
//     this.imageUrl,
//   });
//
//   Category copyWith({
//     String? id,
//     String? name,
//     String? description,
//     String? imageUrl,
//   }) {
//     return Category(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       imageUrl: imageUrl ?? this.imageUrl,
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Category &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           name == other.name;
//
//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
//
//   @override
//   String toString() => 'Category(id: $id, name: $name)';
// }
//


// lib/domain/entities/category.dart

/// Domain entity representing a product category
class Category {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  Category copyWith({
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'Category(id: $id, name: $name)';
}