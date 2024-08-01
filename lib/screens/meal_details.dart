import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/helper/styling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/porvider/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // onToggleFavorite(meal);
              ref
                  .read(favoriteMealProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
              child: Icon(
                Icons.favorite,
                color: ref.watch(favoriteMealProvider).contains(meal)
                    ? Colors.red
                    : Colors.grey,
                key: ValueKey(
                  ref.watch(favoriteMealProvider).contains(meal),
                ),
              ),
            ),
          ),
        ],
        title: Text(
          meal.title,
          style: styledLable,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onDoubleTap: () {
                ref
                    .read(favoriteMealProvider.notifier)
                    .toggleMealFavoriteStatus(meal);
              },
              child: Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15),
            for (final ingerdiant in meal.ingredients)
              Text(
                ingerdiant,
                style: styledBody,
              ),
            const SizedBox(height: 15),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  step,
                  style: styledBody,
                ),
              )
          ],
        ),
      ),
    );
  }
}
