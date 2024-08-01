import 'package:flutter/material.dart';

import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    this.category,
    required this.onCategoryTap,
  });

  final Category? category;
  final void Function(BuildContext, Category?) onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCategoryTap(context, category);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              category != null
                  ? category!.color.withOpacity(0.550)
                  : Colors.grey,
              category != null ? category!.color.withOpacity(0.9) : Colors.grey,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category != null ? category!.title : "All",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
