import 'package:flutter/material.dart';

const darkGreen = Color.fromRGBO(1, 70, 32, 1);
const cream = Color.fromRGBO(255, 255, 242, 1);
const aDarkGreen = Color.fromRGBO(0, 100, 0, 1);
const lCream = Color.fromRGBO(248, 248, 245, 1.0);
const mOrange = Color.fromRGBO(255, 127, 63, 1);
const fillColor =  Color.fromRGBO(245, 248, 239, 1.0);


class ScaleRoute extends MaterialPageRoute {
  final Widget page;

  ScaleRoute({required this.page})
      : super(builder: (BuildContext context) => page);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: child,
    );
  }
}



class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}