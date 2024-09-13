import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/FireBaseManager/FireBaseFunctions.dart';
import 'package:movies/Models/movie_card_model.dart';
import '../Apis/ApiManager.dart';

class Release extends StatefulWidget {

  Release({
    super.key,
  });

  @override
  State<Release> createState() => _ReleaseState();
}

class _ReleaseState extends State<Release> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff282A28),
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: Text(
              'New Releases',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          FutureBuilder(
            future: ApiManager.getsnewreleases(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Something Went Wrong !',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                );
              }
              var release = snapshot.data?.results ?? [];
              return CarouselSlider.builder(

                options: CarouselOptions(
                  viewportFraction: 0.5,
                  aspectRatio: 16 / 9,
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                itemCount: release.length,
                itemBuilder: (context, i, realIndex) {
                  MovieCardModel moviecardmodel=MovieCardModel(
                      id: release[i].id.toString() ?? "",
                      image: release[i].posterPath ?? "",
                      title: release[i].title ?? '',
                      year: release[i].releaseDate?.substring(0, 4) ?? "",
                      additional: release[i].originalTitle ?? "");
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w200${release[i].posterPath}" ??
                                "",
                            height: MediaQuery.of(context).size.height * 0.25,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                         moviecardmodel.isSelected=true;
                          FireBaseFunctions.addmovie(moviecardmodel);
                        },
                        child: Container(
                            decoration:BoxDecoration(
                  color: Color.fromARGB(230, 81, 79, 79),  // Set the background color
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),  // Curved top-left corner
                  bottomLeft: Radius.circular(10),  // Curved bottom-left corner
                  topRight: Radius.circular(10),  // No curve on top-right
                  bottomRight: Radius.circular(0),
                  )),
                          height: MediaQuery.of(context).size.height * 0.06,
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),

                          child: Icon(
                            moviecardmodel.isSelected?Icons.done: Icons.add,
                            color:Colors.white,
                          ),
                        ),
                      ),
                      ],
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

