import 'package:flutter/material.dart';
import 'package:recipe_proj/search_bar/search_list.dart';
import 'package:recipe_proj/db/db_helper.dart';


class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  String keyword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).padding * 1.2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Row(
                   children: [
                     IconButton(
                         onPressed: (){
                           Navigator.pop(context);
                         }, 
                         icon: const Icon(Icons.arrow_back_ios)),
                     SizedBox(
                       height: 36,
                       width: MediaQuery.of(context).size.width * 0.8,
                       child: TextField(
                         textAlign: TextAlign.center,
                         decoration: InputDecoration(
                           suffix: const Icon(Icons.sort, color: Colors.black26,),
                           prefix: const Icon(Icons.search, color: Colors.black26,),
                           contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                           focusedBorder:OutlineInputBorder(
                             borderSide: const BorderSide(color: Colors.black12, width: 2.0),
                             borderRadius: BorderRadius.circular(10)),
                           filled: true,
                           fillColor: Colors.white,
                           border: OutlineInputBorder(
                             borderSide: const BorderSide(
                               color: Colors.black12
                             ),
                             borderRadius: BorderRadius.circular(10)
                           ),
                             enabledBorder: OutlineInputBorder(
                                 borderSide: const BorderSide(
                                     color: Colors.black12
                                 ),
                                 borderRadius: BorderRadius.circular(10)
                             ),

                             hintText:'Поиск рецептов',
                           hintStyle: const TextStyle(color: Colors.black26)
                         ),
                         onChanged: (value){

                           setState(() {
                             keyword = value;

                           });
                         },
                       ),
                     ),
                   ],
                 ),
                       const SizedBox(
                         height: 16,
                       ),
                 StreamBuilder(
                   stream: DatabaseHelper.searchItems(keyword),
                   builder: (context, snapshot) {
                     if (snapshot.hasData) {
                       var data = snapshot.data;
                       return RecipeList(data);
                     } else if (snapshot.hasError) {
                       return Text('Error: ${snapshot.error}');
                     } else {
                       return const Center(child: CircularProgressIndicator());
                     }
                   },
                 )
                   ],
                   ),

            ),
          ),
        ),
      ),
    );
  }
}
