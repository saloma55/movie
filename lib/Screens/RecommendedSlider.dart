import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Apis/ApiManager.dart';

class RecommendedSlider extends StatelessWidget {
  const RecommendedSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(future: ApiManager.getrecommend(), builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }
      if(snapshot.hasError){
        return Center(
          child: Text('Something Went Wrong !',style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.red

          ),),
        );
      }
      var recommended =snapshot.data?.results??[];
      return CarouselSlider(

        options: CarouselOptions(
            viewportFraction: 0.5,
            aspectRatio: 16/9,
            autoPlay: false,
            height: 250.0
        ),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 10
                  ),
                  width: MediaQuery.of(context).size.width*0.5,
                  decoration: BoxDecoration(

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network("https://image.tmdb.org/t/p/w200${recommended[i].posterPath}"??"",
                      width: 96.87,height: 127.4,
                      fit: BoxFit.fill,),
                  )
              );

            },
          );
        }).toList(),
      );
    },);
  }
}
