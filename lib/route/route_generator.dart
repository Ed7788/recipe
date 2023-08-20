import 'package:flutter/material.dart';
import 'package:recipe_proj/animation/m_animation.dart';
import 'package:recipe_proj/screen/add_recipe_page.dart';
import 'package:recipe_proj/screen/select_recipe_screen.dart';
import 'package:recipe_proj/search_bar/search_2.dart';
import '../main.dart';

const String homeRoute = '/';
const String addRecipePage = '/add_recipe';
const String selectRecipe = '/select_recipe';
const String selectScreen = '/select_screen';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder:(context) => const HomePage());
      case addRecipePage :
        return ScaleRoute(page: const AddRecipePage());
      case selectRecipe :
        return ScaleRoute(page: SelectRecipe());
      case selectScreen :
        return ScaleRoute(page: const SelectScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}







