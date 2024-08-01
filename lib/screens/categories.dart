import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() {
    return _StateCategoriesScreen();
  }
}

class _StateCategoriesScreen extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    super.initState();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category? category) {
    List<Meal>? filteredMeals;
    if (category != null) {
      filteredMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(category.id),
          )
          .toList();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category != null ? category.title : "All",
          meals: filteredMeals ?? widget.availableMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        padding: const EdgeInsets.all(15),
        children: [
          CategoryGridItem(
            category: null,
            onCategoryTap: _selectCategory,
          ),
          ...availableCategories.map(
            (e) {
              return CategoryGridItem(
                category: e,
                onCategoryTap: _selectCategory,
              );
            },
          ),
        ],
      ),
      builder: (contexr, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.bounceInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
