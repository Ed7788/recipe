import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Text("Empty Screen", style: TextStyle(color: CupertinoColors.black),),
        ),
      ),
    );
  }
}



