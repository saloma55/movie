import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/HomeScreen.dart';
import 'package:movies/Screens/ViewDetails.dart';

import 'Screens/CategoryMovies.dart';

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
        CategoryMovies.routeName:(context) =>CategoryMovies() ,
        ViewDetails.routeName:(context) => ViewDetails(),
        HomeScreen.routeName:(context) => HomeScreen(),
      },
    );
  }


}