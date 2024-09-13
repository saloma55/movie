import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Apis/ApiManager.dart';
import '../FireBaseManager/FireBaseFunctions.dart';
import '../Models/movie_card_model.dart';

class Similars extends StatelessWidget {
  num movieID;

  Similars({
    super.key,
    required this.movieID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff282A28),
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text(
              'More Like This',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: ApiManager.getSimilarMovies(movieID),
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
              var similars = snapshot.data?.results ?? [];
              return CarouselSlider.builder(
                options: CarouselOptions(
                  viewportFraction: 0.5,
                  aspectRatio: 16 / 9,
                  height: MediaQuery.of(context).size.height * 0.38,
                ),
                itemCount: similars.length,
                itemBuilder: (context, i, realIndex) {
                  MovieCardModel moviemodel = MovieCardModel(
                      id: similars[i].id.toString(),
                      image: similars[i].posterPath ?? "",
                      title: similars[i].title ?? '',
                      year: similars[i].releaseDate ?? "",
                      additional: similars[i].originalTitle ?? "");
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffbac343534),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w200${similars[i].posterPath}" ??
                                    "",
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                fit: BoxFit.fill,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                moviemodel.isSelected = true;
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
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              "  ${similars[i].voteAverage}" ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 8,
                              top: 7,
                              bottom: 7,
                            ),
                            child: Text(
                              similars[i].title ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            similars[i].releaseDate ?? "",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
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
