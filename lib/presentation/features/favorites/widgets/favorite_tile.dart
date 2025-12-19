import 'package:flutter/material.dart';
import '../../../../core/models/favorite.dart';
import '../../../shared/app_theme.dart';

import '../../../shared/utils.dart';

class FavoriteTile extends StatelessWidget {
  final Favorite favorite;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteTile({
    super.key,
    required this.favorite,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(favorite.productImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          favorite.productName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            // Text(
            //   AppUtils.truncateText(favorite.productDescription),
            //   style: const TextStyle(fontSize: 12),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            const SizedBox(height: 4),
            Text(
              AppUtils.formatPrice(favorite.productPrice),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            // Text(
            //   'Added ${AppUtils.formatDate(favoriteAddedAt)}',
            //   style: const TextStyle(fontSize: 12, color: AppTheme.secondaryColor),
            // ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: AppTheme.errorColor),
          onPressed: onRemove,
        ),
        onTap: onTap,
      ),
    );
  }
}