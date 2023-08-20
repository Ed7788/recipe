import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:recipe_proj/main.dart';
import '../animation/m_animation.dart';
import '../db/db_helper.dart';
import '../model/recipe_model.dart';
import '../provider/add_recipe_provider.dart';
import '../route/route_generator.dart';
import 'package:provider/provider.dart';
// ignore_for_file: unused_field

class SelectRecipe extends StatefulWidget {
 final List<Map<String, dynamic>> selectedItems = [];
  SelectRecipe({super.key});

  @override
  State<SelectRecipe> createState() => SelectRecipeState();
}


class SelectRecipeState extends State<SelectRecipe> {
  final dateFormKey = GlobalKey<FormState>();

  @override
  void dispose(){
    super.dispose();
    dateController1.dispose();
    dateController2.dispose();
    dateController3.dispose();
  }

  final dateController1 = TextEditingController();
  final dateController2 = TextEditingController();
  final dateController3 = TextEditingController();

  int id = 0;

  String _title = '';
  String time = '';
  String _description = '';
  String portion = '';
  List<String> _steps = [];
  List<String> _ingredients = [];
  List<String> _quantity = [];
  String year = '';
  String month = '';
  String day = '';
  Uint8List? _image;



  List<Map<String, dynamic>> selectedRecipe = [];
  int generateUniqueID() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int random = Random().nextInt(10000);

    return timestamp + random;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: dateFormKey,
          child: SingleChildScrollView(
            child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   IconButton(onPressed: (){
                     Navigator.pop(context);
                   }, icon: const Icon(Icons.arrow_back_ios, color: aDarkGreen)),
                   const SizedBox(
                     width: 80,
                   ),
                    const Center(
                     child: Text("Добавить рецепт",
                         style: TextStyle(
                           color: aDarkGreen,
                           fontSize: 20.0,
                         )),
                   ),
                 ],
               ),
               const SizedBox(
                 height: 20.0,
               ),
               const Padding(
                 padding: EdgeInsets.only(right: 320),
                 child: Text('Дата', style: TextStyle(
                   fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500
                 ),),
               ),
               const SizedBox(
                 height: 10.0,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   SizedBox(
                     height: 100,
                     width: 70,
                     child: TextFormField(
                       controller: dateController1,
                       onChanged: (value) {
                         if(value == '0' || value == '00'){
                           day = '01';
                         }
                         else{
                           day = value;
                         }
                       },
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return '';
                         }
                         int? numericValue = int.tryParse(value);

                         if (numericValue! < 0 || numericValue > 31) {
                           return '';
                         }

                         return null;
                       },
                       inputFormatters: [
                         FilteringTextInputFormatter.digitsOnly,
                       ],
                       keyboardType: TextInputType.datetime,
                      maxLength: 2,
                      decoration: InputDecoration(
                        counterText: '',
                          filled: true,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: day.isEmpty ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red,)): InputBorder.none,
                          fillColor: fillColor,
                          hintText: '01',
                          helperText: '',
                          labelStyle: const TextStyle(color: aDarkGreen)
                      ),
                     ),
                   ),
                   const SizedBox(
                     width: 10.0,
                   ),
                   SizedBox(
                     height: 100,
                     width: 70,
                     child: TextFormField(
                       onChanged: (value) {
                         if(value == '0' || value == '00'){
                           month = '01';
                         }
                         else{
                           month = value;
                         }
                       },
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return '';
                         }
                         int? numericValue = int.tryParse(value);

                         if (numericValue! < 0 || numericValue > 12) {
                           return '';
                         }
                         return null;
                       },
                       controller: dateController2,
                       inputFormatters: [
                         FilteringTextInputFormatter.digitsOnly,
                       ],
                       maxLength: 2,
                       keyboardType: TextInputType.datetime,
                       decoration: InputDecoration(
                         counterText: '',
                           filled: true,
                           enabledBorder: InputBorder.none,
                           focusedBorder: InputBorder.none,
                           border: month.isEmpty ? const OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.red,)): InputBorder.none,
                           fillColor: fillColor,
                           hintText: '01',
                           helperText: '',
                           labelStyle: const TextStyle(color: aDarkGreen)
                       ),
                     ),
                   ),
                   const SizedBox(
                     width: 5.0,
                   ),
                   SizedBox(
                     height: 100,
                     width: 70,
                     child: TextFormField(
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return '';
                         }
                         return null;
                       },
                       onChanged: (value) => year = value,
                       controller: dateController3,
                       inputFormatters: [
                         FilteringTextInputFormatter.digitsOnly,
                       ],
                       maxLength: 4,
                       keyboardType: TextInputType.datetime,
                       decoration: InputDecoration(
                         counterText: '',
                           filled: true,
                           enabledBorder: InputBorder.none,
                           focusedBorder: InputBorder.none,
                           border: year.isEmpty ? const OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.red,)): InputBorder.none,
                           fillColor: fillColor,
                           hintText: '2023',
                           helperText: '',
                           labelStyle: const TextStyle(color: aDarkGreen)
                       ),
                     ),
                   )
                 ],
               ),
              const SizedBox(
                 height: 10.0,
               ),
               const Padding(
                 padding: EdgeInsets.only(right: 228),
                 child: Text('Выберите рецепт', style: TextStyle(
                   color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500
                 ),),
               ),
               const SizedBox(
                 height: 16.0,
               ),
              Consumer<AddRecipeProvider>(
                  builder: (context, provider, child){
                    final selectedItems = provider.recipes;
                    selectedRecipe = selectedItems.map((recipe) {
                      return {
                        'title': recipe.title,
                        'time': recipe.time,
                        'image': recipe.image,
                        'description' : recipe.description,
                        'portion' : recipe.portion,
                        'steps' : recipe.steps,
                        'ingredients' : recipe.ingredients,
                        'quantity' : recipe.quantity,
                      };
                    }).toList();
                    return ListView.separated(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        final recipe = selectedItems[index];
                        final title = recipe.title;
                        final time = recipe.time;
                        final image = recipe.image;
                        return GestureDetector(
                          onLongPress: (){
                            provider.deleteRecipe(recipe);
                          },
                          child: Container(
                            color: fillColor,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: fillColor,
                                      border: Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        height: 100,
                                          width: 90,
                                          child: image != null
                                              ? Image.memory(image, fit: BoxFit.cover)
                                              : Image.asset(
                                            "assets/images/Dish.jpg",
                                            fit: BoxFit.cover,
                                          ),),
                                    ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.cover,
                                          child: SizedBox(
                                            width: 200,
                                            child: Text(
                                              title,
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 100,
                                          width: 60,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 70,
                                                left: 2,
                                                child: Text(
                                                  "$time min", style: const TextStyle(color: mOrange, fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, separatorBuilder: (context,index) {
                       return const SizedBox(
                          height: 10.0,
                        );
                    },
                    );

                  }
              ),
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: (){
                   Navigator.pushNamed(context, selectScreen);
                 },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                     const Text(
                       'Добавить рецепт',
                       style: TextStyle(fontSize: 18, color: aDarkGreen),
                     ),
                     IconButton(
                       onPressed: () {
                         Navigator.pushNamed(context, selectScreen);
                       },
                       icon: const Icon(
                         Icons.add,
                         size: 20,
                         color: mOrange,
                       ),
                     ),
                   ],
                 ),
               ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 44,
                width: 190,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    backgroundColor: mOrange
                  ),
                  onPressed: () async {
                    try {
                      if (dateFormKey.currentState!.validate()) {
                        if (selectedRecipe.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Выберите рецепт'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('добавлено'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        final List<Recipe> selected = selectedRecipe.map((item) {
                          Uint8List? image = item['image'] != null ? item['image'] as Uint8List : null;
                          int id = generateUniqueID();
                          return Recipe(
                              id: id,
                              title:  _title = item['title'],
                              portion: portion = item['portion'],
                              quantity: _quantity = item['quantity'],
                              ingredients: _ingredients = item['ingredients'],
                              time: time = item['time'],
                              description: _description = item['description'],
                              image: image,
                              steps: _steps = item['steps'],
                              year: year,
                              month: month.toString().padLeft(2, '0'),
                              day: day.toString().padLeft(2, '0'),
                          );
                        }).toList();
                        final provider = Provider.of<AddRecipeProvider>(context, listen: false);
                        provider.clearRecipes();
                        await DatabaseHelper.createSelectedRecipes(selected);

                        SchedulerBinding.instance.addPostFrameCallback((_){
                          Navigator.pushAndRemoveUntil(
                            context,
                            SlideRightRoute(page: const HomePage()),
                                (Route<dynamic> route) => route is HomePage,
                          );
                        });
                      }
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Ошибка"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },

                  child: const Center(
                     child: Text(
                       "Сохранить",
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                     ),
                   ),
                 ),
              ),
             ],
            ),
          ),
        ),
      ),
    ));
  }
}
