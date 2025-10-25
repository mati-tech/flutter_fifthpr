import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/app_theme.dart';
import '../state/home_container.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final homeContainer = Provider.of<HomeContainer>(context);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: homeContainer.categories.length,
        itemBuilder: (context, index) {
          final category = homeContainer.categories[index];
          final isSelected = homeContainer.selectedCategory == category;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                homeContainer.filterByCategory(category);
              },
              backgroundColor: Colors.white,
              selectedColor: AppTheme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppTheme.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
              ),
            ),
          );
        },
      ),
    );
  }
}