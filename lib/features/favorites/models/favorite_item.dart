import '../../home/models/product.dart';

class FavoriteItem {
  final String id;
  final Product product;
  final DateTime addedAt;

  FavoriteItem({
    required this.id,
    required this.product,
    required this.addedAt,
  });
}