// lib/data/mappers/cart_item_mapper.dart
import '../../../../core/models/cart_item.dart';
// import '../../domain/entities/cart_item.dart';
// import '../../domain/entities/product.dart';
import '../../../../core/models/product.dart';
import '../dto/cart_item_dto.dart';
// import '../dtos/cart_item_dto.dart';

class CartItemMapper {
  static CartItem toDomain(CartItemDto dto, Product product) {
    return CartItem(
      id: dto.id,
      product: product,
      quantity: dto.quantity,
    );
  }

  static CartItemDto toDto(CartItem cartItem) {
    return CartItemDto(
      id: cartItem.id,
      productId: cartItem.product.id,
      quantity: cartItem.quantity,
      addedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}