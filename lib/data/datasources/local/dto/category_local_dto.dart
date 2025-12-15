/// Local DTO for Category stored in local cache/storage
/// Used for offline access and caching
class CategoryLocalDto {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final DateTime? cachedAt; // Timestamp for cache invalidation

  CategoryLocalDto({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.cachedAt,
  });

  /// Create CategoryLocalDto from JSON (for storage)
  factory CategoryLocalDto.fromJson(Map<String, dynamic> json) {
    return CategoryLocalDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      cachedAt: json['cachedAt'] != null
          ? DateTime.parse(json['cachedAt'] as String)
          : null,
    );
  }

  /// Convert CategoryLocalDto to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (cachedAt != null) 'cachedAt': cachedAt!.toIso8601String(),
    };
  }

  /// Convert list of CategoryLocalDto from JSON list
  static List<CategoryLocalDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CategoryLocalDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

