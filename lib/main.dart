import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/recipe.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/recipe_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Recipe> _availableRecipes = DUMMY_MEALS;
  List<Recipe> _favoritedRecipes = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableRecipes = DUMMY_MEALS.where((recipe) {
        if (_filters['gluten'] && !recipe.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !recipe.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !recipe.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !recipe.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String recipeId) {
    final existingIndex =
        _favoritedRecipes.indexWhere((recipe) => recipe.id == recipeId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedRecipes.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedRecipes.add(
          DUMMY_MEALS.firstWhere((recipe) => recipe.id == recipeId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedRecipes.any((recipe) => recipe.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoritedRecipes),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableRecipes),
        RecipeDetailScreen.routeName: (ctx) => RecipeDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
