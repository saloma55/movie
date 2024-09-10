import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Apis/ApiManager.dart';

import 'Posters.dart';
import 'RecommendedSlider.dart';
import 'Release.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Posters(),
           Container(
           margin: EdgeInsets.symmetric(
             vertical: 10
           ),
           child: Text('New Releases',style: TextStyle(
             color: Colors.white,
             fontSize: 20,
             fontWeight: FontWeight.w300
           ),),
         ),
            Release(),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 10
              ),
              child: Text('Recommended',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300
              ),),
            ),
            RecommendedSlider()

          ]
        ),
      ),
    );
  }
}

