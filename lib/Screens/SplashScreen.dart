import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName='splash';
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    // Timer to navigate to the home screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/movie-splash.png",
              height:MediaQuery.of(context).size.height*0.2,
            ),
          ),
          Center(child: Image.asset("assets/images/movie-title.jpeg",
              height:MediaQuery.of(context).size.height*0.1)
          ),

        ],
      ),

    );

  }
}



