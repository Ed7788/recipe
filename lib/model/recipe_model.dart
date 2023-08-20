import 'dart:typed_data';

class Recipe {
  late final int id;
  final String description;
  final String title;
  final List<String> ingredients;
  final Uint8List? image;
  final String? portion;
  final String time;
  final List<String> quantity;
  final List<String> steps;
  final String day;
  final String month;
  final String year;

  Recipe(
      {required this.id,
      required this.title,
      required this.description,
      required this.portion,
      required this.steps,
      required this.quantity,
      required this.ingredients,
      this.image,
      required this.time,
      required this.year,
      required this.day,
      required this.month
      });

  Recipe.fromJson(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        ingredients = res['ingredients'],
        steps = res['steps'],
        portion = res['portion'],
        image = res['image'],
        time = res['time'],
        quantity = res['quantity'],
         year = res['year'] ?? '',
         month = res['month'] ?? '',
         day = res['day'] ?? '';


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'time': time,
      "image": image,
      "portion": portion,
     'quantity': quantity,
      'steps': steps,
      'year' : year ?? '',
      'month' : month ?? '',
      'day' : day ?? ''
    };
  }
}
