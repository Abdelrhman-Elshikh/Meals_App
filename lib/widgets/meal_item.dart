import 'package:flutter/material.dart';
import 'package:meals_app/helper/styling.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/porvider/favorites_provider.dart';

class MealItem extends ConsumerWidget {
  const MealItem({
    super.key,
    required this.meal,
  });

  final Meal meal;

  void _onMealTap(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          _onMealTap(context, meal);
        },
        onDoubleTap: () {
          ref
              .read(favoriteMealProvider.notifier)
              .toggleMealFavoriteStatus(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black38,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: styledLable,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          lable: "${meal.duration} min",
                        ),
                        const SizedBox(width: 5),
                        MealItemTrait(
                          icon: Icons.work,
                          lable: "${meal.complexity.name} ",
                        ),
                        const SizedBox(width: 5),
                        MealItemTrait(
                          icon: Icons.money,
                          lable: "${meal.affordability.name} ",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (ref.watch(favoriteMealProvider).contains(meal))
              Container(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.favorite,
                  color: Color.fromARGB(255, 255, 17, 0),
                  size: 40,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
