import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';



class RecipeList extends StatefulWidget {
  List<Map<String, dynamic>>? recipe = [];

  RecipeList(this.recipe, {super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  final List<bool> pressed = List.generate(500,(index)=> false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  for(int i = 0; i< pressed.length; i++){
                                    if(i == index){
                                      pressed[i] =! pressed[i];
                                    }
                                  }
                                });
                              },
                              icon: pressed[index] ? const Icon(Icons.favorite, color: Colors.deepOrangeAccent, size: 22, ) : const Icon(Icons.favorite_outline, color: Colors.deepOrangeAccent, size: 22,),
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
        ],
      ),
    );
  }
}