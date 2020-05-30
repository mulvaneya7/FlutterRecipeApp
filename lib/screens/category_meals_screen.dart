import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/recipe_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryRecipes = DUMMY_MEALS.where((recipe) {
      return recipe.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return RecipeItem(
            id: categoryRecipes[index].id,
            title: categoryRecipes[index].title,
            imageUrl: categoryRecipes[index].imageUrl,
            duration: categoryRecipes[index].duration,
            affordability: categoryRecipes[index].affordability,
            complexity: categoryRecipes[index].complexity,
          );
        },
        itemCount: categoryRecipes.length,
      ),
    );
  }
}
