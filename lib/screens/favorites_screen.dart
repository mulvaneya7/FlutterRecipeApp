import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/recipe_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> favoriteRecipes;

  FavoritesScreen(this.favoriteRecipes);

  @override
  Widget build(BuildContext context) {
    if(favoriteRecipes.isEmpty) {
      return Center(
      child: Text('You have no favorites yet - start adding some!'),
    );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return RecipeItem(
            id: favoriteRecipes[index].id,
            title: favoriteRecipes[index].title,
            imageUrl: favoriteRecipes[index].imageUrl,
            duration: favoriteRecipes[index].duration,
            affordability: favoriteRecipes[index].affordability,
            complexity: favoriteRecipes[index].complexity,
          );
        },
        itemCount: favoriteRecipes.length,
      );
    }

    
  }
}
