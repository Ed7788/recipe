import 'package:flutter/cupertino.dart';
import 'package:recipe_proj/model/recipe_model.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        time TEXT,
        image TEXT,
        portion TEXT,
        ingredients TEXT,
        quantity TEXT,
        steps TEXT,
        day TEXT,
        month TEXT,
        year TEXT, 
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
  }
  static Future<void> createSelectedRecipesTable(Database database) async {
    await database.execute("""CREATE TABLE selected_recipes(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    day TEXT,
    month TEXT,
    year TEXT,
    title TEXT,
    image TEXT,
    time TEXT,
    description TEXT,
    portion TEXT,
    ingredients TEXT,
    quantity TEXT,
    steps TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  )""");
  }

  static Future<Database> db() async {
    return openDatabase(
      'recipe.db',
      version: 2,
      onCreate: (Database database, int version) async {
        await createTables(database);
        await createSelectedRecipesTable(database);
      },
    );
  }

  static Future<int> createItem(Recipe recipe) async {
    final db = await DatabaseHelper.db();

    final data = {
      'title': recipe.title,
      'description': recipe.description,
      'time': recipe.time,
      'ingredients': recipe.ingredients.join(' ,'),
      'steps': recipe.steps.join(' ,'),
      'image': recipe.image,
      'portion': recipe.portion,
      'quantity' : recipe.quantity.join(' ,'),
      'year' : recipe.year,
      'month' : recipe.month,
      'day' : recipe.day
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<void> createSelectedRecipes(List<Recipe> selectedRecipes) async {
    final db = await DatabaseHelper.db();

    for (var selectedRecipe in selectedRecipes) {
      final data = {
        'id' : selectedRecipe.id,
        'day': selectedRecipe.day,
        'month': selectedRecipe.month,
        'year': selectedRecipe.year,
        'title': selectedRecipe.title,
        'image': selectedRecipe.image,
        'time' : selectedRecipe.time,
        'description' : selectedRecipe.description,
        'ingredients': selectedRecipe.ingredients.join(' ,'),
        'steps': selectedRecipe.steps.join(' ,'),
        'portion': selectedRecipe.portion,
        'quantity' : selectedRecipe.quantity.join(' ,'),
      };
      final id = await db.insert('selected_recipes', data,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      print('Inserted item with ID: $id');
    }

  }


  static Future<dynamic> retrieveRecipe() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (index) {
      return Recipe(
          id: maps[index]['id'],
          title: maps[index]['title'],
          image: maps[index]['image'],
          steps: maps[index]['steps'].split('\n,').join('\n').split('\n'),
          quantity: maps[index]['quantity'].split(','),
          ingredients: maps[index]['ingredients'].split(','),
          time: maps[index]['time'],
          portion: maps[index]['portion'],
          description: maps[index]['description'],
          year: maps[index]['year'],
          month: maps[index]['month'],
          day: maps[index]['day']
      );
    }).toList();
  }

  static Future<List<Recipe>> retrieveSelectedRecipes(DateTime selectedDay) async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(
      'selected_recipes',
      where: 'day = ? AND month = ?',
      whereArgs: [
        selectedDay.day.toString().padLeft(2, '0'),
        selectedDay.month.toString().padLeft(2, '0')
      ],
    );
    return List.generate(maps.length, (index) {
      return Recipe(
        id: maps[index]['id'],
        title: maps[index]['title'],
        image: maps[index]['image'],
        steps: maps[index]['steps'].split('\n,').join('\n').split('\n'),
        quantity: maps[index]['quantity'].split(','),
        ingredients: maps[index]['ingredients'].split(','),
        time: maps[index]['time'],
        portion: maps[index]['portion'],
        description: maps[index]['description'],
        year: maps[index]['year'],
        month: maps[index]['month'].toString().padLeft(2, '0'),
        day: maps[index]['day'].toString().padLeft(2, '0'),
      );
    });
  }


  static Stream<List<Map<String, dynamic>>> searchItems(String keyword) async* {
    final db = await DatabaseHelper.db();
    yield* db.query('items', where: 'title LIKE ?', whereArgs: ['%$keyword%']).asStream();
  }

  // static Future<int> updateItem(
  //     int id, String title, String? description, String time) async {
  //   final db = await DatabaseHelper.db();
  //
  //   final data = {
  //     'title': title,
  //     'description': description,
  //     'time': time,
  //     'createdAt': DateTime.now().toString()
  //   };
  //
  //   final result =
  //       await db.update('items', data, where: "id = ?", whereArgs: [id]);
  //   return result;
  // }

  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Ошибка: $err");
    }
  }
  static Future<void> deleteItemInProgress(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("selected_recipes", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Ошибка: $err");
    }
  }

}
