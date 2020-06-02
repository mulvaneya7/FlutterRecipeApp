import 'package:flutter/material.dart';

import '../widgets/recipe_item.dart';
import '../models/recipe.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Recipe> availableRecipes;

  CategoryMealsScreen(this.availableRecipes);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Recipe> displayedRecipes;
  var _loadedInitData = false;

  @override
  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedRecipes = widget.availableRecipes.where((recipe) {
        return recipe.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeRecipe(String recipeId) {
    setState(() {
      displayedRecipes.removeWhere((recipe) => recipe.id == recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return RecipeItem(
            id: displayedRecipes[index].id,
            title: displayedRecipes[index].title,
            imageUrl: displayedRecipes[index].imageUrl,
            duration: displayedRecipes[index].duration,
            affordability: displayedRecipes[index].affordability,
            complexity: displayedRecipes[index].complexity,
          );
        },
        itemCount: displayedRecipes.length,
      ),
    );
  }
}
