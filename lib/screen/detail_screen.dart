import 'dart:typed_data';
import '../model/recipe_model.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RecipeDetail extends StatefulWidget {

  final Recipe? recipe;
  const RecipeDetail({super.key, this.recipe});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  static const aDarkGreen = Color.fromRGBO(0, 100, 0, 1);
  bool isPressed = false;
  Recipe? recipe;
 static int _counter = 1;

  Color color = const Color.fromRGBO(248, 249, 243, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                   height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: widget.recipe?.image != null ? Image.memory(widget.recipe?.image as Uint8List, fit: BoxFit.cover,)
                        : Image.asset(
                      "assets/images/Dish.jpg",
                      fit: BoxFit
                          .cover,
                    ),

                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(widget.recipe!.title, style: const TextStyle(
                      fontSize: 22, color: aDarkGreen, fontWeight: FontWeight.w500
                    ),),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.watch_later_outlined, color: aDarkGreen,),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text('Время', style: TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800),),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.62,
                        ),
                        Text('${widget.recipe!.time} мин', style: const TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800), overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: aDarkGreen,),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text('Гостей', style: TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800),),
                        Container(
                          color: color,
                          width: MediaQuery.of(context).size.width * 0.62,
                        ),
                        Text('$_counter чел.', style: const TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800), overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Center(
                    child: Text("Добавить Гостей", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800, color: aDarkGreen),),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                   children: [
                     const SizedBox(
                       width: 100,
                     ),
                     GestureDetector(
                       onLongPress: (){
                         setState(() {
                           _counter = 1;
                         });
                       },
                       child: SizedBox(
                         height: 40,
                         width: 40,
                         child: NeumorphicButton(
                           padding: const EdgeInsets.only(bottom: 14),
                           onPressed: (){
                             decrement();
                           },
                           style: NeumorphicStyle(
                               depth: 5,
                               shape: NeumorphicShape.concave,
                               boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                             color: Colors.white
                           ),
                           child: const Icon(Icons.minimize, color: aDarkGreen,size: 26,),
                         ),
                       ),
                     ),
                     const SizedBox(
                       width: 30,
                     ),
                     SizedBox(
                       height: 40,
                       width: 40,
                       child: Neumorphic(
                         style: NeumorphicStyle(
                             depth: 5,
                             shape: NeumorphicShape.concave,
                             boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                             color: Colors.white
                         ),
                         child: Center(child: Text('$_counter', style: const TextStyle(fontSize: 18.0, color: Colors.orange),))
                       ),
                     ),
                     const SizedBox(
                       width: 30,
                     ),
                     SizedBox(
                       height: 40,
                       width: 40,
                       child: NeumorphicButton(
                         padding: const EdgeInsets.symmetric(horizontal: 9),
                         onPressed: (){
                           increment();
                         },
                         style: NeumorphicStyle(
                           depth: 5,
                           shape: NeumorphicShape.concave,
                           boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                           color: Colors.white
                         ),
                         child: const Icon(Icons.add, color: aDarkGreen, size: 26,),
                       ),
                     )
                   ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                   const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                        child: Text("Описание", style: TextStyle(color: aDarkGreen, fontWeight: FontWeight.w700, fontSize: 16),)),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      color: color,
                        child: Text(widget.recipe!.description, style: const TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800),)),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Ингредиенты", style: TextStyle(color: aDarkGreen, fontWeight: FontWeight.w700, fontSize: 16),)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 ListView.separated(
                   physics: const ScrollPhysics(),
                   padding: EdgeInsets.zero,
                   shrinkWrap: true,
                   itemCount: widget.recipe!.ingredients.length,
                     itemBuilder: (context, index){
                     String quantity = (widget.recipe!.quantity[index]);
                     int currentQuantity = int.parse(quantity);
                     int updatedQuantity = currentQuantity * _counter;
                     String updatedQuantityString = updatedQuantity.toString();
                 return Container(
                   color: color,
                   child: ListTile(
                       leading: Text(widget.recipe!.ingredients[index], style: const TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800)),
                       trailing: Text(updatedQuantityString.toString(), style: const TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800)),
                     ),
                 );
                     }, separatorBuilder: (BuildContext context, int index) {
                     return const SizedBox(
                       height: 4.0,
                     );
                 },
                 ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(" Шаги", style: TextStyle(color: aDarkGreen, fontWeight: FontWeight.w700, fontSize: 16),)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: widget.recipe!.steps.length,
                      itemBuilder: (context, index){
                        return Container(
                          color: color,
                          child: ListTile(
                            subtitle: Text(widget.recipe!.steps[index], style: const TextStyle(color: aDarkGreen, fontWeight: FontWeight.w800),softWrap: true,),
                          ),
                          );
                      }, separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 4.0,
                        );
                  },
                  ),
                  const SizedBox(
                    height: 40.0,
                  )
                ],
              ),
              Positioned(right: 60, top: 56, child: GestureDetector(
                onTap: (){
                  setState(() {
                    isPressed =! isPressed;
                  });
                },
                  child: Icon(isPressed ? Icons.favorite : Icons.favorite_outline, color: isPressed ? Colors.red : Colors.white,))),
              const Positioned(
                right: 20, top: 56,
                  child: Icon(Icons.airplay_sharp, color: Colors.white,)),
              Positioned(
                 left: 20, top: 56,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white,))
              )
            ],
          ),
        )


    );
  }
  void increment(){
    setState(() {
      _counter++;
    });
  }
  void decrement(){
    setState(() {
      if(_counter <= 1) return;
      _counter--;
    });
  }
}