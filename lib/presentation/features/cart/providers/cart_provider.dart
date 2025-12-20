// lib/presentation/features/cart/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/cart.dart';
import '../../../../core/models/cart_product.dart';
import '../../../../data/repositories/providers.dart';
// import '../../../../domain/usecases/cart/get_cart_by_user_usecase.dart';
import '../../../../domain/usecases/cart/get_cart_items_usecase.dart';

final getCartByUserUseCaseProvider = Provider<GetCartByUserUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetCartByUserUseCase(repository);
});

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final useCase = ref.watch(getCartByUserUseCaseProvider);
  return CartNotifier(ref, useCase);
});

class CartNotifier extends StateNotifier<CartState> {
  final Ref ref;
  final GetCartByUserUseCase getCartByUserUseCase;

  CartNotifier(this.ref, this.getCartByUserUseCase) : super(const CartState()) {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate a delay like fetching from API
      await Future.delayed(const Duration(seconds: 1));

      // Demo cart data based on your JSON
      final cartItems = [
        Cart(
          id: 38,
          userId: 15,
          total: 3359.79,
          discountedTotal: 3262.64,
          totalProducts: 6,
          totalQuantity: 21,
          products: [
            CartProduct(
              id: 44,
              title: "Family Tree Photo Frame",
              price: 29.99,
              quantity: 5,
              total: 149.95,
              discountPercentage: 10.68,
              discountedTotal: 133.94,
              thumbnail:
              "https://cdn.dummyjson.com/products/images/home-decoration/Family%20Tree%20Photo%20Frame/thumbnail.png",
            ),
            CartProduct(
              id: 68,
              title: "Pan",
              price: 24.99,
              quantity: 3,
              total: 74.97,
              discountPercentage: 5.16,
              discountedTotal: 71.1,
              thumbnail:
              "https://cdn.dummyjson.com/products/images/kitchen-accessories/Pan/thumbnail.png",
            ),
            CartProduct(
              id: 149,
              title: "Iron Golf",
              price: 49.99,
              quantity: 4,
              total: 199.96,
              discountPercentage: 12.89,
              discountedTotal: 174.19,
              thumbnail:
              "https://cdn.dummyjson.com/products/images/sports-accessories/Iron%20Golf/thumbnail.png",
            ),
            CartProduct(
              id: 139,
              title: "Baseball Glove",
              price: 24.99,
              quantity: 3,
              total: 74.97,
              discountPercentage: 12.13,
              discountedTotal: 65.88,
              thumbnail:
              "https://cdn.dummyjson.com/products/images/sports-accessories/Baseball%20Glove/thumbnail.png",
            ),
            CartProduct(
              id: 150,
              title: "Metal Baseball Bat",
              price: 29.99,
              quantity: 2,
              total: 59.98,
              discountPercentage: 18.43,
              discountedTotal: 48.93,
              thumbnail:
              "https://cdn.dummyjson.com/products/images/sports-accessories/Metal%20Baseball%20Bat/thumbnail.png",
            ),
            CartProduct(
              id: 133,
              title: "Samsung Galaxy S10",
              price: 699.99,
              quantity: 4,
              total: 2799.96,
              discountPercentage: 1.12,
              discountedTotal: 2768.6,
              thumbnail:
              "https://cdn.dummyjson.com/products/images/smartphones/Samsung%20Galaxy%20S10/thumbnail.png",
            ),
          ],
        ),
      ];

      // Set state with demo cart items
      state = state.copyWith(items: cartItems, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

}

// CartState
class CartState {
  final List<Cart> items;
  final bool isLoading;
  final String? error;

  const CartState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  CartState copyWith({
    List<Cart>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get isEmpty => items.isEmpty;
}
