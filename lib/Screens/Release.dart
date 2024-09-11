import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Apis/ApiManager.dart';

class Release extends StatelessWidget {
   Release({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: ApiManager.getsnewreleases(), builder: (context, snapshot) {
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
      var release =snapshot.data?.results??[];
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
              return Stack(
                children: [
                  Container(
                   height: 250,
                      margin: EdgeInsets.symmetric(
                          horizontal: 10
                      ),
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network("https://image.tmdb.org/t/p/w200${release[i].posterPath}"??"",
                          width: 100,height: 127.4,
                          fit: BoxFit.fill,),
                      )
                  ),
                  Container(
                    width: 27,
                    height: 36,
                    margin: EdgeInsets.only(
                      left: 10
                    ),
                    decoration: BoxDecoration(
                     borderRadius: BorderRadius.only(
                       topRight: Radius.circular(4),
                       topLeft: Radius.circular(4)
                     ),
                      color: Color(0xff514F4F)
                    ),
                    child: Icon(Icons.add,color: Colors.white),
                  )

              ],
              );

            },
          );
        }).toList(),
      );
    },);
  }
}
