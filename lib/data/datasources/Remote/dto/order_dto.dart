// lib/data/dtos/order_dto.dart
class OrderDto {
  final String id;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final String orderDate;
  final String status;
  final String shippingAddress;
  final String? trackingNumber;

  OrderDto({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.shippingAddress,
    this.trackingNumber,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
      id: json['id']?.toString() ?? '',
      items: List<Map<String, dynamic>>.from(json['items'] ?? []),
      totalAmount: (json['totalAmount'] ?? json['total_amount'] ?? 0.0).toDouble(),
      orderDate: json['orderDate']?.toString() ?? json['order_date']?.toString() ?? '',
      status: json['status']?.toString() ?? 'pending',
      shippingAddress: json['shippingAddress']?.toString() ?? json['shipping_address']?.toString() ?? '',
      trackingNumber: json['trackingNumber']?.toString() ?? json['tracking_number']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'status': status,
      'shippingAddress': shippingAddress,
      if (trackingNumber != null) 'trackingNumber': trackingNumber,
    };
  }
}