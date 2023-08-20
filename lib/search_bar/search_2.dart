import 'package:flutter/material.dart';
import '../animation/m_animation.dart';
import '../db/db_helper.dart';
import '../model/recipe_model.dart';
import '../screen/chose_recipe.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

List<Recipe> myData = [];

class _SelectScreenState extends State<SelectScreen> {
  List<Recipe> myData = [];
  Color color = const Color.fromRGBO(248, 249, 243, 1);
  String keyword = '';

  dynamic _refreshData() async {
    dynamic data = await DatabaseHelper.retrieveRecipe();
    setState(() {
      myData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode searchFocusNode = FocusNode();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios,
                            color: aDarkGreen)),
                    const SizedBox(
                      width: 80,
                    ),
                    const Center(
                      child: Text("Выбрать рецепт",
                          style: TextStyle(
                            color: aDarkGreen,
                            fontSize: 20.0,
                          )),
                    ),
                  ],
                ),
                myData.isEmpty
                    ? Padding(
                        padding: MediaQuery.of(context).padding * 5,
                        child: const Center(
                            child: Text("У вас нет записанных рецептов",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: aDarkGreen,
                                    fontWeight: FontWeight.w700))),
                      )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 36,
                          child: GestureDetector(
                            child: TextFormField(
                                focusNode: searchFocusNode,
                              onChanged: (value) => setState(() {
                                keyword = value;
                              }),
                                textAlign: TextAlign.center,
                                //readOnly: true,
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
                                  setState(() {});
                                }),
                          ),
                        ),
                       const SizedBox(
                          height: 10.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        StreamBuilder(
                          stream: DatabaseHelper.searchItems(keyword),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data;
                              return SearchSelect(data);
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        )
                      ],
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
