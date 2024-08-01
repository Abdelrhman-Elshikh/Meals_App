import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/porvider/filters_provider.dart';

class FilterItem extends ConsumerWidget {
  const FilterItem({
    super.key,
    required this.filterValue,
    required this.title,
    required this.subTitle,
    required this.filter,
  });

  final bool filterValue;
  final String title;
  final String subTitle;
  final Filter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      value: filterValue,
      onChanged: (isChecked) {
        ref.read(filtersProvider.notifier).setFilter(filter, isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 25,
        right: 20,
      ),
    );
  }
}
