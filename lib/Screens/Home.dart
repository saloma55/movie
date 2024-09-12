import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Posters.dart';
import 'RecommendedSlider.dart';
import 'Release.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Posters(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Release(),
                  RecommendedSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
