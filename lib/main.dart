import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recipe_proj/provider/add_recipe_provider.dart';
import 'package:recipe_proj/route/route_generator.dart';
import 'package:recipe_proj/screen/main_screen.dart';
import 'package:recipe_proj/text.dart';
import 'animation/m_animation.dart';
import 'screen/add_recipe_page.dart';
import 'screen/gridview_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}


int _selectedTab = 0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddRecipeProvider>(
      create: (context) => AddRecipeProvider(),
      child: MaterialApp(
        localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ], supportedLocales: const [
      Locale('ru', ''),
    ],
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: homeRoute,
        debugShowCheckedModeBanner: false,
          title: 'Flutter Recipe App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                color: aDarkGreen,
              ),
            )
          ),
          ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  const Text('Вы уверены, что хотите выйти', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: aDarkGreen),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  const Text('Нет', style: TextStyle(color: Colors.orange),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:  const Text('Да', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    )) ?? false;
  }


_changeTab(int index) {
    setState(() {
      if(index == 2){
        return;
      }
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: darkGreen,
        showUnselectedLabels: true,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        items: <BottomNavigationBarItem> [
          const BottomNavigationBarItem(
            icon:Icon(Icons.home_outlined),
            label: "Главная",
          ),
          BottomNavigationBarItem(
              icon:SvgPicture.asset("assets/images/book.svg",matchTextDirection: false, height: 26, width: 26, fit: BoxFit.scaleDown, color: _selectedTab == 1 ? darkGreen : Colors.grey,),
              label: 'Рецепты'
          ),
          BottomNavigationBarItem(
            icon:Container(
              height: 40,
              width: 54,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(10.0)
                ),
              ),
              child: GestureDetector(
                onLongPress: (){
                  showModalBottomSheet<void>(
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return  SizedBox(
                        height: 262,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  Navigator.pushNamed(context, selectRecipe);
                                },
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.save_outlined,weight: 1, color: aDarkGreen),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          TextButton(style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          onPressed: (){
                                            Navigator.pushNamed(context, selectRecipe);
                                          }, child: const Text("Подкинь делишек", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),)),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 146.0),
                                        child: Text("Добавить в список дел", style: TextStyle(color: Colors.grey,),textAlign: TextAlign.right),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:   const [
                                  Icon(Icons.add_circle_outline_outlined,weight: 1, color: aDarkGreen),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Создать новый рецепт", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 28.0),
                                child: Text("Записать в рецепты", style: TextStyle(color: Colors.grey,),textAlign: TextAlign.right),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:  const [
                                  Icon(Icons.add_box_outlined,weight: 1, color: aDarkGreen),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Добавить коллекцию", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 28.0),
                                child: Text("Обновить список рецептов", style: TextStyle(color: Colors.grey,),textAlign: TextAlign.right),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(Icons.camera_alt_outlined,weight: 1, color: aDarkGreen),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Scan Recipe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 28.0),
                                child: Text("", style: TextStyle(color: Colors.grey,),textAlign: TextAlign.right),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: IconButton(onPressed: () {
                  Navigator.pushNamed(context, addRecipePage);
                },
                  icon:const Icon(Icons.add_outlined,color: Colors.white,),),
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
              icon:Icon(Icons.favorite_border_outlined),
              label: 'Любимые'
          ),
          const BottomNavigationBarItem(
              icon:Icon(Icons.person_outlined),
              label: 'Кабинет'
          ),
        ],
      ),
        body: IndexedStack(
          index: _selectedTab,
          children: const [
            MainScreen(),
            Grid(),
            AddRecipePage(),
            MyText(),
            MyText(),
          ],
        )
      ),
    );
  }
}

