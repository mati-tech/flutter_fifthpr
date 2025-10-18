import 'package:flutter/material.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/app_button.dart';

class CartSummary extends StatelessWidget {
  final double totalPrice;
  final int itemCount;
  final VoidCallback onCheckout;

  const CartSummary({
    super.key,
    required this.totalPrice,
    required this.itemCount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total ($itemCount ${itemCount == 1 ? 'item' : 'items'})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                AppUtils.formatPrice(totalPrice),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'Proceed to Checkout',
            onPressed: onCheckout,
          ),
        ],
      ),
    );
  }
}