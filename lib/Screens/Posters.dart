import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Apis/ApiManager.dart';

class Posters extends StatelessWidget {
   Posters({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(future: ApiManager.getposter(), builder: (context, snapshot) {
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
      var popularpost =snapshot.data?.results??[];
      return CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            height: 400.0),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width*1,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                  child: Image.network("https://image.tmdb.org/t/p/w200${popularpost[i].posterPath}"??"",width: double.infinity,fit: BoxFit.fill,)
              );

            },
          );
        }).toList(),
      );
    },);
  }
}
