// // lib/presentation/features/orders/providers/order_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/models/order.dart';
// import '../../../../core/models/cart_item.dart';
// import '../../../../data/datasources/remote/order_api_datasource.dart';
// // import '../../../../data/datasources/mock_order_api_datasource.dart';
// import '../../../../data/repositories/order_repository_impl.dart';
// import '../../../../domain/usecases/order/create_order_usecase.dart';
// import '../../../../domain/usecases/order/get_orders_usecase.dart';
// // import '../../../../domain/usecases/orders/create_order_usecase.dart';
// // import '../../../../domain/usecases/orders/get_orders_usecase.dart';
//
// // ========== DEPENDENCY PROVIDERS ==========
// final orderDataSourceProvider = Provider<OrderApiDataSource>((ref) {
//   return MockOrderApiDataSource();
// });
//
// final orderRepositoryProvider = Provider<OrderRepositoryImpl>((ref) {
//   final dataSource = ref.watch(orderDataSourceProvider);
//   return OrderRepositoryImpl(dataSource);
// });
//
// final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
//   final repository = ref.watch(orderRepositoryProvider);
//   return CreateOrderUseCase(repository);
// });
//
// final getOrdersUseCaseProvider = Provider<GetOrdersUseCase>((ref) {
//   final repository = ref.watch(orderRepositoryProvider);
//   return GetOrdersUseCase(repository);
// });
//
// // ========== ORDER STATE PROVIDER ==========
// class OrderNotifier extends StateNotifier<OrderState> {
//   final Ref ref;
//
//   OrderNotifier(this.ref) : super(const OrderState()) {
//     loadOrders();
//   }
//
//   Future<void> loadOrders() async {
//     state = state.copyWith(isLoading: true);
//
//     try {
//       final useCase = ref.read(getOrdersUseCaseProvider);
//       final orders = await useCase.execute();
//
//       state = state.copyWith(
//         orders: orders,
//         isLoading: false,
//       );
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//     }
//   }
//
//   Future<Order> createOrder({
//     required List<CartItem> items,
//     required String shippingAddress,
//   }) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final useCase = ref.read(createOrderUseCaseProvider);
//       final newOrder = await useCase.execute(
//         items: items,
//         shippingAddress: shippingAddress,
//       );
//
//       // Add to local state
//       final updatedOrders = [...state.orders, newOrder];
//
//       state = state.copyWith(
//         orders: updatedOrders,
//         isLoading: false,
//       );
//
//       return newOrder;
//     } catch (error) {
//       state = state.copyWith(
//         error: error.toString(),
//         isLoading: false,
//       );
//       rethrow;
//     }
//   }
//
//   Future<void> cancelOrder(String orderId) async {
//     state = state.copyWith(isLoading: true, error: null);
//
//     try {
//       final repository = ref.read(orderRepositoryProvider);
//       await repository.cancelOrder(orderId);
//
//       // Update local state
//       final updatedOrders = state.orders.map((order) {
//         if (order.id == orderId) {
//           return order; // In real app, update status to cancelled
//         }
//         return order;
//       }).toList();
//
//       state = state.copyWith(
//         orders: updatedOrders,
//         isLoading: false,
//       );
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
// final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
//   return OrderNotifier(ref);
// });
//
// // ========== ORDER STATE ==========
// class OrderState {
//   final List<Order> orders;
//   final bool isLoading;
//   final String? error;
//
//   const OrderState({
//     this.orders = const [],
//     this.isLoading = false,
//     this.error,
//   });
//
//   bool get isEmpty => orders.isEmpty;
//   bool get hasOrders => orders.isNotEmpty;
//   int get orderCount => orders.length;
//
//   OrderState copyWith({
//     List<Order>? orders,
//     bool? isLoading,
//     String? error,
//   }) {
//     return OrderState(
//       orders: orders ?? this.orders,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );
//   }
// }