import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:recipe_proj/search_bar/search_bar.dart';
import 'package:recipe_proj/model/recipe_model.dart';
import 'package:recipe_proj/db/db_helper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../animation/m_animation.dart';
import 'detail_screen.dart';

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);



  @override
  GridState createState() => GridState();
}

class GridState extends State<Grid> {
  bool _isLoading = true;
  final List<Recipe> selectedRecipes = [];
  List<Recipe> myData = [];
  bool isPressed = false;
  Color color = const Color.fromRGBO(248, 249, 243, 1);
  final List<bool> pressed = List.generate(500, (index) => false);
  late DatabaseHelper dbHelper;

  dynamic _refreshData() async {
    dynamic data = await DatabaseHelper.retrieveRecipe();
    setState(() {
     myData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    _refreshData();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Рецепт удален'),
        backgroundColor: Colors.deepOrangeAccent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SingleChildScrollView(
        child: _isLoading
            ? Padding(
                padding: MediaQuery.of(context).padding * 5,
                child: const Center(
                    child: Text("У вас нет записанных рецептов",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: aDarkGreen,
                            fontWeight: FontWeight.w700))),
              )
            : Padding(
                padding: MediaQuery.of(context).padding * 1.1,
                child: Column(
                  children: [
                    const Text("Рецепты",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: aDarkGreen,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isPressed = false;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: isPressed ? Colors.white : aDarkGreen),
                            child: Center(
                                child: Text(
                              "Рецепты",
                              style: TextStyle(
                                  color: isPressed ? aDarkGreen : color),
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: isPressed ? aDarkGreen : color),
                            child: Center(
                                child: Text(
                              "Коллекции",
                              style: TextStyle(
                                  color: isPressed ? color : aDarkGreen),
                            )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 36,
                      child: GestureDetector(
                        child: TextFormField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            decoration: InputDecoration(
                                suffix: const Icon(
                                  Icons.sort,
                                  color: Colors.black26,
                                ),
                                prefix: const Icon(
                                  Icons.search,
                                  color: Colors.black26,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal:  10.0),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black12, width: 2.0),
                                    borderRadius: BorderRadius.circular(16)),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Поиск рецептов',
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                )),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MySearchBar()));
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: DatabaseHelper.retrieveRecipe(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 2,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: ScaleAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                          child: GestureDetector(
                                            onLongPress: (){
                                              setState(() {
                                                deleteItem(myData[index].id);
                                              });
                                            },
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                RecipeDetail(
                                                              recipe: myData[index],
                                                            ),
                                                          ));
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: SizedBox(
                                                          height: 200,
                                                          width: 200,
                                                          child: myData[index].image ==
                                                                  null
                                                              ? Image.asset(
                                                                  "assets/images/Dish.jpg",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : Image.memory(
                                                                  myData[index].image
                                                                      as Uint8List,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                    alignment:
                                                        const Alignment(-1, 0.93),
                                                    child: Text(
                                                      myData[index].title,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                        color: Colors.black45,
                                                        fontFamily: 'Cera Pro',
                                                        fontSize: 14,
                                                      ),
                                                    )),
                                                Positioned(
                                                  top: 170,
                                                  left: 10,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        myData[index].time.toString(),
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .deepOrangeAccent),
                                                      ),
                                                      const SizedBox(
                                                        width: 2.0,
                                                      ),
                                                      const Text('min',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepOrangeAccent)),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const Alignment(1.2, 1.13),
                                                  child: Container(
                                                    height: 46,
                                                    width: 46,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30)),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          for (int i = 0;
                                                              i < pressed.length;
                                                              i++) {
                                                            if (i == index) {
                                                              pressed[i] =
                                                                  !pressed[i];
                                                            }
                                                          }
                                                        });
                                                      },
                                                      icon: pressed[index]
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors
                                                                  .deepOrangeAccent,
                                                              size: 22,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_outline,
                                                              color: Colors
                                                                  .deepOrangeAccent,
                                                              size: 22,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 256,
                                        crossAxisSpacing: 1));
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        })
                  ],
                ),
              ),
      ),
    );
  }
}
