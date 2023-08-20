import 'package:flutter/cupertino.dart';
import 'package:recipe_proj/model/recipe_model.dart';

class AddRecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = [];

  List<Recipe> get recipes {
    return List<Recipe>.from(_recipes);
  }

  int get recipeCount {
    return _recipes.length;
  }

  void addRecipe(List<Recipe> newRecipes) {
    _recipes.addAll(newRecipes);
    notifyListeners();
  }
  void deleteRecipe(Recipe recipe) {
    _recipes.remove(recipe);
    notifyListeners();
  }
  void clearRecipes() {
    _recipes.clear();
    notifyListeners();
  }


}
