import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/porvider/filters_provider.dart';
import 'package:meals_app/widgets/filter_item.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("your Filters"),
      ),
      body: Column(
        children: [
          FilterItem(
            filterValue: activeFilter[Filter.glutenFree]!,
            filter: Filter.glutenFree,
            title: "Gluten-free",
            subTitle: 'Only include gluten-free meals.',
          ),
          FilterItem(
            filterValue: activeFilter[Filter.lactoseFree]!,
            filter: Filter.lactoseFree,
            title: "Lactose-free",
            subTitle: 'Only include Lactose-free meals.',
          ),
          FilterItem(
            filterValue: activeFilter[Filter.vegetarian]!,
            filter: Filter.vegetarian,
            title: "Vegetarian",
            subTitle: 'Only include Vegetarian meals.',
          ),
          FilterItem(
            filterValue: activeFilter[Filter.vegan]!,
            filter: Filter.vegan,
            title: "Vegen",
            subTitle: 'Only include Vegen meals.',
          ),
        ],
      ),
    );
  }
}
