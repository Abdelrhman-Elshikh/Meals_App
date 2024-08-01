import 'package:flutter/material.dart';
import 'package:meals_app/helper/styling.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    // initialize the body contint
    late Widget body;

    // check if there is no meals
    // initialize a empty column
    if (meals.isEmpty) {
      body = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nothing here!",
              style: styledLable,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "try selecting a different category!",
              style: styledLable,
            )
          ],
        ),
      );

      // if category has a meals
    } else if (meals.isNotEmpty) {
      body = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: MealItem(
            meal: meals[index],
          ),
        ),
      );
    }

    if (title == null) {
      return body;
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: const [],
          title: Text(
            title!,
            style: styledLable,
          ),
        ),
        body: body,
      );
    }
  }
}
