// import '../../features/home/models/product.dart';
import 'package:storelytech/core/models/product.dart';




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