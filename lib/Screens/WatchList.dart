import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/FireBaseManager/FireBaseFunctions.dart';
import 'package:movies/Models/movie_card_model.dart';

class WatchList extends StatelessWidget {
  MovieCardModel? movieCardModel ;
  static const String routeName="watch";
  WatchList({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Container(
        margin:EdgeInsets.only(
          top: 18.0
        ),
        child: Text("WatchList",style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w500
        ),),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder(stream: FireBaseFunctions.getmovies(), builder:  (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError){
          return Text('Error');
        }
        var movies =snapshot.data?.docs.map((e) => e.data()).toList();
        return ListView.separated(
          itemCount: movies!.length,
            separatorBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 7.0,
                  ),
                  Divider(
                    color: Color(0xffcbcbcb),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                ],
              );
            },

          itemBuilder: (context, index) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Image.network("https://image.tmdb.org/t/p/w500${movies[index].image}",
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width * 0.4,),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movies[index].title, style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(movies[index].year, style: TextStyle(
                        color: Color(0xffcbcbcb),
                      )),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(movies[index].additional,style: TextStyle(
                        color: Color(0xffcbcbcb),
                      ))
                    ],
                  ),
                )
              ],
            );
          },);
      }),
    ) ,
     );

  }
}



