import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_proj/db/db_helper.dart';
import 'package:recipe_proj/main.dart';
import 'package:recipe_proj/model/recipe_model.dart';
import 'package:image_picker/image_picker.dart';
import '../animation/m_animation.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  AddRecipePageState createState() => AddRecipePageState();
}

class AddRecipePageState extends State<AddRecipePage> {
  DatabaseHelper? dbHelper;
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _timeController = TextEditingController();
  final _portionController = TextEditingController();
  final List<TextEditingController> _ingredientsController = [];
  final List<TextEditingController> stepsController = [];
  final List<TextEditingController> _quaController = [];

  int id = 0;
  String _title = '';
  String time = '';
  String _description = '';
  String portion = '';
  final List<String> _steps = [];
  final List<String> _ingredients = [];
  final List<String> _quantity = [];
  String year = '';
  String month = '';
  String day = '';


  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
      _quantity.removeAt(index);
    });
  }


  @override
  void dispose() {
    for (final controller in _ingredientsController) {
      controller.dispose();
    }
    for (final controller in _quaController) {
      controller.dispose();
    }
    for (final controller in stepsController) {
      controller.dispose();
    }
     titleController.dispose();
    _instructionsController.dispose();
    _timeController.dispose();


    super.dispose();
  }
  @override
  void initState() {
    _addIngredientField();
    super.initState();
  }

  void _addIngredientField() {
    setState(() {
      _ingredients.add('');
      _quantity.add('');
      _ingredientsController.add(TextEditingController());
      _quaController.add(TextEditingController());
    });
  }
  getFromGallery(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    }
  }

  void selectImage() async {
    Uint8List imageFile = await getFromGallery(ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });
  }

  Uint8List? _image;

  clearImage() {
    setState(() {
      _image = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [

                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios, color: aDarkGreen,)),
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
                    height: 10.0,
                  ),
                  const Text(
                    "Название",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: aDarkGreen,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                    height: 70.0,
                    width: 358.0,
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          fillColor: fillColor,
                          hintText: 'Название Рецепта',
                          helperText: '',
                          labelStyle: TextStyle(color: aDarkGreen)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста введите название';
                        }
                        return null;
                      },
                      onChanged: (value) => _title = value,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    color: fillColor,
                    height: 120,
                    width: 357.0,
                    child: Center(
                      child: Column(
                        children: [
                          _image == null
                              ? IconButton(
                                  onPressed: () {
                                    selectImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: aDarkGreen,
                                  ))
                              : CircleAvatar(
                                  radius: 34,
                                  child: SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: ClipOval(
                                        child: Image.memory(
                                      _image!,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.network(
                                              'https://e2.edimdoma.ru/data/posts/0002/0173/20173-ed4_wide.jpg?1495006926'),
                                    )),
                                  ),
                                ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Добавить фото",
                                  style: TextStyle(
                                    color: aDarkGreen,
                                    fontSize: 14.0,
                                  )),
                              IconButton(
                                tooltip: 'удалить',
                                onPressed: () {
                                  clearImage();
                                },
                                icon: const Icon(
                                  Icons.close_sharp,
                                  color: aDarkGreen,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Инструкция",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: aDarkGreen,
                        fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: 358,
                    height: 134,
                    color: fillColor,
                    child: TextFormField(
                      maxLines: 4,
                      controller: _instructionsController,
                      decoration: const InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          fillColor: fillColor,
                          hintText: 'Опишите свой рецепт',
                          helperText: '',
                          labelStyle: TextStyle(
                              color: aDarkGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста введите инструкцию';
                        }
                        return null;
                      },
                      onChanged: (value) => _description = value,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text('Время',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: aDarkGreen,
                                    fontSize: 16.0)),
                            SizedBox(
                              width: 150,
                            ),
                            Text('Порция',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: aDarkGreen,
                                    fontSize: 16.0))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 52,
                              width: 172,
                              color: fillColor,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста введите время';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                                controller: _timeController,
                                onChanged: (value) => time = value,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    hintText: '00:20',
                                    fillColor: fillColor,
                                    helperText: '',
                                    labelStyle: TextStyle(
                                        color: aDarkGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            Container(
                              height: 52,
                              width: 172,
                              color: fillColor,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста введите количество порции';
                                  }
                                  return null;
                                },
                                onChanged: (value) => portion = value,
                                keyboardType: TextInputType.number,
                                controller: _portionController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: fillColor,
                                    hintText: 'порция',
                                    helperText: '',
                                    labelStyle: TextStyle(
                                        color: aDarkGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _ingredients.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _ingredients.length ) {
                          return TextButton(
                            onPressed: _addIngredientField,
                            child: const Center(
                              child: Text(
                                'Добавить Ингредиенты',
                                style: TextStyle(fontSize: 16, color: mOrange),
                              ),
                            ),
                          );
                        }
                        if(index == 0){
                          return Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Обязательное поле";
                                      }
                                      return null;
                                    },
                                  controller: _ingredientsController[index],
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: fillColor,
                                      helperText: '',
                                      hintText: 'Индегренты',
                                      labelStyle: TextStyle(
                                          color: aDarkGreen,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      _ingredients[index] = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextFormField(
                                  validator: (value) {
                                    if (index == 0) {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста введите количество';
                                      }
                                      return null;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _quaController[index],
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: fillColor,
                                      hintText: 'кол.',
                                      helperText: '',
                                      labelStyle: TextStyle(
                                          color: aDarkGreen,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      _quantity[index] = value;
                                    });
                                  },
                                ),
                              ),
                              IgnorePointer(
                               ignoring: true,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.close,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return Dismissible(
                          key: ValueKey(_ingredientsController[index]),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction){
                            setState(() {
                              _ingredientsController.removeAt(index);
                              _quaController.removeAt(index);
                              _removeIngredient(index);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          secondaryBackground:Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Обязательное поле";
                                      }
                                      return null;
                                  },
                                  controller: _ingredientsController[index],
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: fillColor,
                                      helperText: '',
                                      hintText: 'Индегренты',
                                      labelStyle: TextStyle(
                                          color: aDarkGreen,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      _ingredients[index] = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextFormField(
                                  validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста введите количество';
                                      }
                                      return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _quaController[index],
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: fillColor,
                                      hintText: 'кол.',
                                      helperText: '',
                                      labelStyle: TextStyle(
                                          color: aDarkGreen,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      _quantity[index] = value;
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if(index == 0){
                                    return;
                                  }
                                  _ingredientsController.removeAt(index);
                                  _quaController.removeAt(index);
                                  _removeIngredient(index);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _steps.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _steps.length) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                _steps.add('');
                                stepsController.add(TextEditingController());
                              });
                            },
                            child: const Center(
                              child: Text(
                                'Добавить шаг',
                                style: TextStyle(fontSize: 16, color: mOrange),
                              ),
                            ),
                          );
                        }
                        return Dismissible(
                          key: ValueKey(stepsController[index]),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction){
                            setState(() {
                              stepsController.removeAt(index);
                              _steps.removeAt(index);

                            });
                          },
                          background: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          secondaryBackground:Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  maxLines: 4,
                                  validator: (value) {
                                    if (index == 0) {
                                      if (value == null || value.isEmpty) {
                                        return "Обязательное поле";
                                      }
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: stepsController[index],
                                  decoration: const InputDecoration(
                                      helperText: '',
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: fillColor,
                                      hintText: 'Описание',
                                      labelStyle: TextStyle(
                                          color: aDarkGreen,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      _steps[index] = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                color: Colors.redAccent,
                                child: IconButton(
                                  onPressed: () {
                                    stepsController.removeAt(index);
                                    setState(() {
                                      _steps.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.delete_outline_sharp,
                                      size: 24, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.only(left: 100, bottom: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        backgroundColor: mOrange,
        onPressed: () async {
          try {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Рецепт сохранен'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushAndRemoveUntil(
                  context,
                  SlideRightRoute(page: const HomePage()),
                  (Route<dynamic> route) => route is HomePage);
              DatabaseHelper.createItem(Recipe(
                  id: id,
                  title: _title,
                  portion: portion,
                  quantity: _quantity,
                  ingredients: _ingredients,
                  time: time,
                  description: _description,
                  image: _image,
                  steps: _steps,
                year: year,
                month: month,
                day: day

              ));
            }
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Ошибка сохранения данных"),
              backgroundColor: Colors.red,
            ));
          }
        },
        label: Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Сохранить",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
