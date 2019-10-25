import 'package:flutter/material.dart';
import 'pages/home-page.dart';
import 'pages/intro.dart';
import 'pages/save.dart';
import "pages/corg.dart";
import "pages/answer.dart";
//import 'pages/intro.dart';

var routes = <String, WidgetBuilder>{
  "/app": (BuildContext context) => HomePage(),
  "/corg": (BuildContext context) => corgclass(),
  "/save": (BuildContext context) => save(),
  "/intro": (BuildContext context) => data_homemain()
};

void main() => runApp(new MaterialApp(
    theme:
        ThemeData(primaryColor: Colors.blue, accentColor: Colors.yellowAccent),
    debugShowCheckedModeBanner: false,
    home: HomePage(), // SplashScreen(),
    routes: routes));
