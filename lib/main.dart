import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/HomeScreen.dart';
import 'package:movies/Screens/ViewDetails.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        ViewDetails.routeName:(context) => ViewDetails(),
        HomeScreen.routeName:(context) => HomeScreen()
      },
    );
  }


}