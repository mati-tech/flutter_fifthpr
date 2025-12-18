// // import 'package:riverpod_annotation/riverpod_annotation.dart';
// // import '../../../../core/models/cart_item.dart';
// // import '../../../../core/models/product.dart';
// // // import '../models/cart_item.dart';
// // // import '../../home/models/product.dart';
// //
// // part 'cart_provider.g.dart';
// //
// // @riverpod
// // class CartNotifier extends _$CartNotifier {
// //   @override
// //   CartState build() {
// //     return CartState(cartItems: []);
// //   }
// //
// //   void addToCart(Product product, {int quantity = 1}) {
// //     final currentItems = List<CartItem>.from(state.cartItems);
// //     final existingIndex = currentItems.indexWhere(
// //       (item) => item.product.id == product.id,
// //     );
// //
// //     if (existingIndex != -1) {
// //       currentItems[existingIndex] = currentItems[existingIndex].copyWith(
// //         quantity: currentItems[existingIndex].quantity + quantity,
// //       );
// //     } else {
// //       currentItems.add(CartItem(
// //         id: DateTime.now().millisecondsSinceEpoch.toString(),
// //         product: product,
// //         quantity: quantity,
// //       ));
// //     }
// //
// //     state = CartState(cartItems: currentItems);
// //   }
// //
// //   void removeFromCart(String productId) {
// //     final currentItems = List<CartItem>.from(state.cartItems);
// //     currentItems.removeWhere((item) => item.product.id == productId);
// //     state = CartState(cartItems: currentItems);
// //   }
// //
// //   void updateQuantity(String productId, int newQuantity) {
// //     if (newQuantity <= 0) {
// //       removeFromCart(productId);
// //       return;
// //     }
// //
// //     final currentItems = List<CartItem>.from(state.cartItems);
// //     final existingIndex = currentItems.indexWhere(
// //       (item) => item.product.id == productId,
// //     );
// //
// //     if (existingIndex != -1) {
// //       currentItems[existingIndex] = currentItems[existingIndex].copyWith(
// //         quantity: newQuantity,
// //       );
// //       state = CartState(cartItems: currentItems);
// //     }
// //   }
// //
// //   // void incrementQuantity(String productId) {
// //   //   updateQuantity(productId, getQuantity(productId) + 1);
// //   // }
// //   //
// //   // void decrementQuantity(String productId) {
// //   //   updateQuantity(productId, getQuantity(productId) - 1);
// //   // }
// //
// //   // int getQuantity(String productId) {
// //   //   final item = state.cartItems.firstWhere(
// //   //     (item) => item.product.id == productId,
// //   //     orElse: () => CartItem(
// //   //       id: '',
// //   //       product: Product(
// //   //         id: '',
// //   //         name: '',
// //   //         description: '',
// //   //         price: 0,
// //   //         imageUrl: '',
// //   //         category: '',
// //   //         stock: 0, brand: '',     kQuantity: null, isFeatured: null, createdAt: null,
// //   //       ),
// //   //     ),
// //   //   );
// //   //   return item.quantity;
// //   // }
// //
// //   void clearCart() {
// //     state = CartState(cartItems: []);
// //   }
// //
// //   bool isInCart(String productId) {
// //     return state.cartItems.any((item) => item.product.id == productId);
// //   }
// // }
// //
// // class CartState {
// //   final List<CartItem> cartItems;
// //
// //   CartState({required this.cartItems});
// //
// //   int get cartItemsCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
// //   double get totalPrice =>
// //       cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
// // }
// //
//
//
// // lib/presentation/features/cart/providers/cart_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/models/cart_item.dart';
// import '../../../../data/datasources/Remote/cart_api_datasource.dart';
// import '../../../../data/datasources/Remote/product_api_datasource.dart';
// // import '../../../../data/datasources/cart_api_datasource.dart';
// // import '../../../../data/datasources/mock_cart_api_datasource.dart';
// // import '../../../../data/datasources/mock_product_api_datasource.dart';
// import '../../../../data/repositories/cart_repository_impl.dart';
// import '../../../../data/repositories/get_cart_total_usecase.dart';
// import '../../../../domain/usecases/cart/add_to_cart_usecase.dart';
// import '../../../../domain/usecases/cart/remove_from_cart_usecase.dart';
// import '../../../../domain/usecases/cart/update_quantity_usecase.dart';
// import '../../../../domain/usecases/cart/get_cart_items_usecase.dart';
// import '../../../shared/api_client_provider.dart';
// // import '../../../../domain/usecases/cart/get_cart_total_usecase.dart';
// // import '../../../../domain/usecases/cart/get_cart_count_usecase.dart';
// // import '../../../../domain/usecases/cart/check_in_cart_usecase.dart';
//
// // ========== DEPENDENCY PROVIDERS ==========
//
// // Cart Data Source
// final cartDataSourceProvider = Provider<CartApiDataSource>((ref) {
//   return MockCartApiDataSource();
// });
//
// // Product Data Source (FastAPI-backed)
// final productDataSourceProvider = Provider<ProductApiDataSource>((ref) {
//   final apiClient = ref.watch(apiClientProvider);
//   return FastApiProductApiDataSource(apiClient);
// });
//
// // Cart Repository
// final cartRepositoryProvider = Provider<CartRepositoryImpl>((ref) {
//   final cartDataSource = ref.watch(cartDataSourceProvider);
//   final productDataSource = ref.watch(productDataSourceProvider);
//
//   return CartRepositoryImpl(
//     cartDataSource: cartDataSource,
//     productDataSource: productDataSource,
//   );
// });
//
// // Cart Use Cases
// final addToCartUseCaseProvider = Provider<AddToCartUseCase>((ref) {
//   final repository = ref.watch(cartRepositoryProvider);
//   return AddToCartUseCase(repository);
// });
//
// final removeFromCartUseCaseProvider = Provider<RemoveFromCartUseCase>((ref) {
//   final repository = ref.watch(cartRepositoryProvider);
//   return RemoveFromCartUseCase(repository);
// });
//
// final updateQuantityUseCaseProvider = Provider<UpdateQuantityUseCase>((ref) {
//   final repository = ref.watch(cartRepositoryProvider);
//   return UpdateQuantityUseCase(repository);
// });
//
// final getCartItemsUseCaseProvider = Provider<GetCartItemsUseCase>((ref) {
//   final repository = ref.watch(cartRepositoryProvider);
//   return GetCartItemsUseCase(repository);
// });
//
// final getCartTotalUseCaseProvider = Provider<GetCartTotalUseCase>((ref) {
//   final repository = ref.watch(cartRepositoryProvider);
//   return GetCartTotalUseCase(repository);
// });
//
//
//
//
// // ========== CART STATE PROVIDER ==========
//
// class CartNotifier extends StateNotifier<CartState> {
//   final Ref ref;
//
//   CartNotifier(this.ref) : super(const CartState()) {
//     // Load cart items when provider is created
//     loadCartItems();
//   }
//
//   Future<void> loadCartItems() async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final useCase = ref.read(getCartItemsUseCaseProvider);
//       final items = await useCase.execute();
//
//       state = state.copyWith(
//         items: items,
//         isLoading: false,
//       );
//       _updateCalculatedValues();
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//     }
//   }
//
//   Future<void> addToCart(String productId, {int quantity = 1}) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final useCase = ref.read(addToCartUseCaseProvider);
//       final newItem = await useCase.execute(productId, quantity: quantity);
//
//       // Check if item already exists
//       final existingIndex = state.items.indexWhere(
//             (item) => item.product.id == productId,
//       );
//
//       List<CartItem> updatedItems;
//       if (existingIndex != -1) {
//         // Update existing item quantity
//         updatedItems = List.from(state.items);
//         final existingItem = updatedItems[existingIndex];
//         updatedItems[existingIndex] = existingItem.copyWith(
//           quantity: existingItem.quantity + quantity,
//         );
//       } else {
//         // Add new item
//         updatedItems = [...state.items, newItem];
//       }
//
//       state = state.copyWith(
//         items: updatedItems,
//         isLoading: false,
//       );
//       _updateCalculatedValues();
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//       rethrow;
//     }
//   }
//
//   Future<void> removeFromCart(String cartItemId) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final useCase = ref.read(removeFromCartUseCaseProvider);
//       await useCase.execute(cartItemId);
//
//       final updatedItems = state.items
//           .where((item) => item.id != cartItemId)
//           .toList();
//
//       state = state.copyWith(
//         items: updatedItems,
//         isLoading: false,
//       );
//       _updateCalculatedValues();
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//       rethrow;
//     }
//   }
//
//   Future<void> updateQuantity(String cartItemId, int quantity) async {
//     if (quantity <= 0) {
//       await removeFromCart(cartItemId);
//       return;
//     }
//
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final useCase = ref.read(updateQuantityUseCaseProvider);
//       final updatedItem = await useCase.execute(cartItemId, quantity);
//
//       final updatedItems = state.items.map((item) {
//         if (item.id == cartItemId) {
//           return updatedItem;
//         }
//         return item;
//       }).toList();
//
//       state = state.copyWith(
//         items: updatedItems,
//         isLoading: false,
//       );
//       _updateCalculatedValues();
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//       rethrow;
//     }
//   }
//
//   Future<void> incrementQuantity(String cartItemId) async {
//     final item = state.items.firstWhere(
//           (item) => item.id == cartItemId,
//       orElse: () => throw Exception('Item not found'),
//     );
//
//     if (item.canIncrease) {
//       await updateQuantity(cartItemId, item.quantity + 1);
//     }
//   }
//
//   Future<void> decrementQuantity(String cartItemId) async {
//     final item = state.items.firstWhere(
//           (item) => item.id == cartItemId,
//       orElse: () => throw Exception('Item not found'),
//     );
//
//     if (item.quantity > 1) {
//       await updateQuantity(cartItemId, item.quantity - 1);
//     } else {
//       await removeFromCart(cartItemId);
//     }
//   }
//
//   Future<void> clearCart() async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final repository = ref.read(cartRepositoryProvider);
//       await repository.clearCart();
//
//       state = state.copyWith(
//         items: [],
//         isLoading: false,
//       );
//       _updateCalculatedValues();
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//       rethrow;
//     }
//   }
//
//
//
//   Future<double> getCartTotal() async {
//     try {
//       final useCase = ref.read(getCartTotalUseCaseProvider);
//       return await useCase.execute();
//     } catch (error) {
//       return 0.0;
//     }
//   }
//
//
//
//   // Helper to update calculated values
//   void _updateCalculatedValues() {
//     final subtotal = state.items.fold(
//       0.0,
//           (total, item) => total + item.totalPrice,
//     );
//
//     final totalItems = state.items.length;
//     final totalQuantity = state.items.fold(
//       0,
//           (total, item) => total + item.quantity,
//     );
//
//     // Calculate tax (example: 8% tax)
//     final tax = subtotal * 0.08;
//
//     // Shipping (example: $5.99 flat rate)
//     final shipping = 5.99;
//
//     final total = subtotal + tax + shipping;
//
//     state = state.copyWith(
//       subtotal: subtotal,
//       tax: tax,
//       shipping: shipping,
//       total: total,
//       totalItems: totalItems,
//       totalQuantity: totalQuantity,
//     );
//   }
//
//   // Apply coupon
//   Future<void> applyCoupon(String couponCode) async {
//     if (couponCode.isEmpty) {
//       state = state.copyWith(
//         couponCode: null,
//         discount: 0,
//         discountPercentage: 0,
//       );
//       _updateCalculatedValues();
//       return;
//     }
//
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final repository = ref.read(cartRepositoryProvider);
//       final discountPercentage = await repository.applyCoupon(couponCode);
//
//       final discountAmount = state.subtotal * (discountPercentage / 100);
//
//       state = state.copyWith(
//         couponCode: couponCode,
//         discount: discountAmount,
//         discountPercentage: discountPercentage,
//         isLoading: false,
//       );
//       _updateCalculatedValues();
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//       rethrow;
//     }
//   }
//
//   // Calculate shipping
//   Future<void> calculateShipping(String address) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final repository = ref.read(cartRepositoryProvider);
//       final shipping = await repository.calculateShipping(address);
//
//       state = state.copyWith(
//         shipping: shipping,
//         isLoading: false,
//       );
//       _updateCalculatedValues();
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//       rethrow;
//     }
//   }
//
//   void clearError() {
//     if (state.error != null) {
//       state = state.copyWith(error: null);
//     }
//   }
// }
//
// final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
//   return CartNotifier(ref);
// });
//
// // ========== CART STATE ==========
//
// class CartState {
//   final List<CartItem> items;
//   final bool isLoading;
//   final String? error;
//
//   // Calculated values
//   final double subtotal;
//   final double tax;
//   final double shipping;
//   final double total;
//   final double discount;
//   final double discountPercentage;
//   final String? couponCode;
//
//   // Counts
//   final int totalItems;
//   final int totalQuantity;
//
//   const CartState({
//     this.items = const [],
//     this.isLoading = false,
//     this.error,
//     this.subtotal = 0.0,
//     this.tax = 0.0,
//     this.shipping = 0.0,
//     this.total = 0.0,
//     this.discount = 0.0,
//     this.discountPercentage = 0.0,
//     this.couponCode,
//     this.totalItems = 0,
//     this.totalQuantity = 0,
//   });
//
//   bool get isEmpty => items.isEmpty;
//   bool get hasItems => items.isNotEmpty;
//   bool get hasDiscount => discount > 0;
//   bool get isCartLoading => isLoading;
//
//   double get grandTotal => total - discount;
//
//   CartState copyWith({
//     List<CartItem>? items,
//     bool? isLoading,
//     String? error,
//     double? subtotal,
//     double? tax,
//     double? shipping,
//     double? total,
//     double? discount,
//     double? discountPercentage,
//     String? couponCode,
//     int? totalItems,
//     int? totalQuantity,
//   }) {
//     return CartState(
//       items: items ?? this.items,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       subtotal: subtotal ?? this.subtotal,
//       tax: tax ?? this.tax,
//       shipping: shipping ?? this.shipping,
//       total: total ?? this.total,
//       discount: discount ?? this.discount,
//       discountPercentage: discountPercentage ?? this.discountPercentage,
//       couponCode: couponCode ?? this.couponCode,
//       totalItems: totalItems ?? this.totalItems,
//       totalQuantity: totalQuantity ?? this.totalQuantity,
//     );
//   }
// }