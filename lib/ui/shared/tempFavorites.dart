import '../../core/models/product.dart';


class TempFavorites {
  static final List<Product> _list = [];

  static void toggle(Product product) {
    if (_list.any((p) => p.id == product.id)) {
      _list.removeWhere((p) => p.id == product.id);
    } else {
      _list.add(product);
    }
    print('Temp favorites: ${_list.length} items');
  }

  static bool contains(String productId) {
    return _list.any((p) => p.id == productId);
  }

  static List<Product> get all => List.from(_list);

  static void clear() {
    _list.clear();
  }
}