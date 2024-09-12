import 'package:flutter/material.dart';
import 'package:movies/FireBaseManager/FireBaseFunctions.dart';
import 'package:movies/Models/movie_card_model.dart';
import 'package:movies/Screens/movie_item.dart';

class WatchList extends StatelessWidget {
  MovieCardModel? movieCardModel;

  static const String routeName = "WatchList";

  WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Watchlist",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
            stream: FireBaseFunctions.getmovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error');
              }
              var movies = snapshot.data?.docs.map((e) => e.data()).toList();
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
                  return MovieItem(
                    movieCardModel: MovieCardModel(
                      image:
                          "https://image.tmdb.org/t/p/w500${movies[index].image}",
                      title: movies[index].title,
                      year: movies[index].year,
                      additional: movies[index].additional,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
