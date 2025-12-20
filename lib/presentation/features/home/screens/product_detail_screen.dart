import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/widgets/app_button.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем детали продукта при открытии экрана
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    final homeNotifier = ref.read(homeProvider.notifier);
    await homeNotifier.getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final homeState = ref.watch(homeProvider);
    final selectedProduct = homeState.selectedProduct;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenWidth > 800 ? 400 : 300,
            pinned: true,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              // Кнопка избранного (только для дизайна)
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {
                  // TODO: Добавить функционал избранного позже
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-image-${widget.productId}',
                child: selectedProduct?.images[0] != null
                    ? Image.network(
                  selectedProduct!.images[0],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth > 800 ? 64 : 16,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название продукта и категория
                  if (selectedProduct != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedProduct.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.accentColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          // child: Text(
                          //   selectedProduct.category,
                          //   style: TextStyle(
                          //     color: AppTheme.accentColor,
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ),
                        const SizedBox(height: 16),
                        // Цена
                        Text(
                          '\$${selectedProduct.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Описание
                        if (selectedProduct.description != null &&
                            selectedProduct.description!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                selectedProduct.description!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  else
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  const SizedBox(height: 40),
                  // Разделитель перед кнопками
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                text: 'Add to Cart',
                onPressed: () {
                  // TODO: Добавить функционал корзины
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                text: 'Buy Now',
                onPressed: () {
                  // TODO: Добавить функционал покупки
                },
                backgroundColor: AppTheme.accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}