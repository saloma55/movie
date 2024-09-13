import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/ViewDetails.dart';
import '../Apis/ApiManager.dart';
import '../FireBaseManager/FireBaseFunctions.dart';
import '../Models/movie_card_model.dart';

class Posters extends StatefulWidget {
  Posters({super.key});

  @override
  State<Posters> createState() => _PostersState();
}

class _PostersState extends State<Posters> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getposter(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
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
        var popularpost = snapshot.data?.results ?? [];
        return CarouselSlider.builder(
          options: CarouselOptions(
            viewportFraction: 1.0,
            autoPlay: true,
            height: MediaQuery.of(context).size.height*0.37,
          ),
          itemCount: popularpost.length,
          itemBuilder: (context, i, realIndex) {
            MovieCardModel moviemodel = MovieCardModel(
                id: popularpost[i].id.toString() ?? "",
                image: popularpost[i].posterPath ?? "",
                title: popularpost[i].title ?? '',
                year:
                popularpost[i].releaseDate?.substring(0, 4) ?? "",
                additional: popularpost[i].originalTitle ?? "");
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ViewDetails.routeName,
                  arguments: popularpost[i].id,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w200${popularpost[i].posterPath}" ??
                                "",
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                            left: 110,
                          ),
                          child: Text(
                            popularpost[i].title ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffcbcbcb),
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 100,
                          ),
                          child: Text(
                            popularpost[i].releaseDate?.substring(0, 10) ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w200${popularpost[i].posterPath}" ??
                                  "",
                              height: 200,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              moviemodel.isSelected=true;
                              FireBaseFunctions.addmovie(moviemodel);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/save_image.png",
                                  height: MediaQuery.of(context).size.height *
                                      0.05,
                                  color: moviemodel.isSelected
                                      ? Color.fromARGB(230, 255, 255, 0)
                                      : Color.fromARGB(230, 81, 79, 79),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: 5.0,
                                  ),
                                  child: Icon(
                                    moviemodel.isSelected
                                        ? Icons.done
                                        : Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
