// lib/domain/entities/favorite_item.dart
import 'product.dart';

class FavoriteItem {
  final String id;
  final Product product;
  final DateTime addedAt;

  FavoriteItem({
    required this.id,
    required this.product,
    required this.addedAt,
  });

  FavoriteItem copyWith({
    String? id,
    Product? product,
    DateTime? addedAt,
  }) {
    return FavoriteItem(
      id: id ?? this.id,
      product: product ?? this.product,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}