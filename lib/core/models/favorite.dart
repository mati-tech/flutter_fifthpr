class Favorite {
  final String id; // favorite id
  final String userId;
  final String productId;
  final String productName;
  final String productImageUrl;
  final double productPrice;
  final String productCategory; // Add this if you need it

  Favorite({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.productPrice,
    this.productCategory = '', // Default empty
  });
}