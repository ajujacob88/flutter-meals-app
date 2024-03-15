import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //Navigator.push(context, route);

    //since we are in a stateless widget, context is not globally available, so we need to accept contxt value in the function

    // Navigator.of(context).push(route); this is also same as Navigator.push(context, route); so anyone can be used

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (ctx) => MealsScreen(
    //       title: 'some title',
    //       meals: [],
    //     ),
    //   ),
    // );

    //both are same

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Pick your category'),
    //   ),
//no need of scafold appBar since in the tabScreen, we provided a scafold and appBar title

    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),

      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],

      //another alternative of using for loop here is using maps

      // children: availableCategories
      //     .map((category) => CategoryGridItem(category: category))
      //     .toList(),
    );
  }
}
