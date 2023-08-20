import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recipe_proj/animation/m_animation.dart';
import 'package:provider/provider.dart';
import 'package:recipe_proj/db/db_helper.dart';
import 'package:recipe_proj/model/recipe_model.dart';
import '../provider/add_recipe_provider.dart';



class SearchSelect extends StatefulWidget {
  List<Map<String, dynamic>>? recipe = [];
  SearchSelect(this.recipe, {super.key});

  @override
  State<SearchSelect> createState() => _SearchSelectState();
}

class _SearchSelectState extends State<SearchSelect> {
  final List<bool> pressed = List.generate(500,(index)=> false);
  List<Map<String, dynamic>> selectedItems = [];
  List<int> selectedIds = [];
  Recipe? recipe;
  bool _isSnackBarShown = false;
  late DatabaseHelper helper;

  @override
  Widget build(BuildContext context) {
    return
       SingleChildScrollView(
        child: Column(
          children: [
            selectedItems.isNotEmpty ? Column(
              children :[
               const Padding(
                  padding: EdgeInsets.only(right: 274),
                  child: Text("Выбранные", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                GridView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                      child: Stack(
                      fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: selectedItems[index]['image'] == null ?
                                    Image.asset("assets/images/Dish.jpg", fit: BoxFit.cover,
                                    )
                                        : Image.memory(selectedItems[index]['image'], fit: BoxFit.cover,
                                    )
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: const Alignment(-1, 0.93),
                              child: Text(selectedItems[index]['title'], softWrap: true, maxLines: 2,  style: const TextStyle(color: Colors.black45, fontFamily: 'Cera Pro', fontSize: 14,
                              ),)
                          ),
                          Positioned(
                            top: 170,
                            left: 10,
                            child: Row(
                              children:[
                                Text(selectedItems[index]['time'], style: const TextStyle(color: Colors.deepOrangeAccent),),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                const Text('min', style: TextStyle(color: Colors.deepOrangeAccent)),
                              ],
                            ),
                          ),
                          Align(
                            alignment:const Alignment(1.2, 1.13),
                            child: Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedItems.removeAt(index);
                                      selectedIds.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.close, color: mOrange, size: 18.0,)
                              ),
                            ),
                          ),
                        ],
                    ),
                    ),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 256,
                      crossAxisSpacing: 1),
                )
              ]
              ) : const SizedBox(
              height: 0.0,
            ),


            const Padding(
              padding: EdgeInsets.only(right: 300),
              child: Text("Рецепты", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.recipe?.length,
              itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                duration: const Duration(milliseconds: 1000),
                child: ScaleAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: widget.recipe![index]['image'] == null ?
                                  Image.asset("assets/images/Dish.jpg", fit: BoxFit.cover,
                                  )
                                      : Image.memory(widget.recipe![index]['image'], fit: BoxFit.cover,
                                  )
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: const Alignment(-1, 0.93),
                            child: Text(widget.recipe![index]['title'], softWrap: true, maxLines: 2,  style: const TextStyle(color: Colors.black45, fontFamily: 'Cera Pro', fontSize: 14,
                            ),)
                        ),
                        Positioned(
                          top: 170,
                          left: 10,
                          child: Row(
                            children:[
                              Text(widget.recipe![index]['time'], style: const TextStyle(color: Colors.deepOrangeAccent),),
                              const SizedBox(
                                width: 2.0,
                              ),
                              const Text('min', style: TextStyle(color: Colors.deepOrangeAccent)),
                            ],
                          ),
                        ),
                        Align(
                          alignment:const Alignment(1.2, 1.13),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: IconButton(
                              onPressed: (){
                                final item = widget.recipe![index];
                                final itemId = item['id'];
                                if (!selectedIds.contains(itemId)) {
                                  setState(() {
                                    selectedItems.add(item);
                                    selectedIds.add(itemId);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Рецепт уже выбран", style: TextStyle(color: Colors.grey),),
                                    backgroundColor: Colors.white,
                                  ));
                                  return;
                                }

                              },
                              icon: const Icon(Icons.add, color: mOrange,)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 256,
                  crossAxisSpacing: 1),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              height: 44,
              width: 190,
              child: ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<AddRecipeProvider>(context, listen: false);
                  if (selectedItems.isEmpty) {
                    if(!_isSnackBarShown) {
                      _isSnackBarShown = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("рецепт не выбран", style: TextStyle(
                              color: Colors.red
                          ),),
                          backgroundColor: Colors.white,
                        ),
                      );
                    }
                    return;
                  }
                  bool hasDuplicate = selectedItems.any((item) {
                    return provider.recipes.any((recipe) => recipe.id == item['id']);
                  });

                  if (hasDuplicate) {
                    String duplicateTitle = '';
                    for (var item in selectedItems) {
                      var duplicateRecipe = provider.recipes.firstWhere((recipe) => recipe.id == item['id']);
                      duplicateTitle = duplicateRecipe.title;
                      break;
                    }

                    String duplicateMessage = 'Рецепт "$duplicateTitle" уже добавлен в список';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          duplicateMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    );
                    return;
                  }

                  final List<Recipe> recipes = selectedItems.map((item) {

                    List<String> ingredients = [item['ingredients'] as String];
                    List<String> steps = (item['steps'] as String).split(',');
                    List<String> quantity = (item['quantity'] as String).split(',');
                    Uint8List? image = item['image'] != null ? item['image'] as Uint8List : null;

                    return Recipe(
                      title: item['title'],
                      time: item['time'],
                      image: image,
                      id: item['id'],
                      description: item['description'],
                      portion: item['portion'],
                      steps: steps,
                      quantity: quantity,
                      ingredients: ingredients,
                      year: item['year'] ?? '',
                      month: item['month'] ?? '',
                      day: item['day'] ?? ''
                    );
                  }).toList();
                  provider.addRecipe(recipes);
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();

                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: mOrange
                ),
                child: const Center(
                  child: Text(
                    "Сохранить",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ]
      )
        );


  }
}