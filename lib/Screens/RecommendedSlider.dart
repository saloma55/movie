import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Models/movie_card_model.dart';
import '../Apis/ApiManager.dart';
import '../FireBaseManager/FireBaseFunctions.dart';

class RecommendedSlider extends StatelessWidget {
  const RecommendedSlider({super.key});

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
              horizontal: 10,
            ),
            child: Text(
              'Recommended',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          FutureBuilder(
            future: ApiManager.getrecommend(),
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
              var recommended = snapshot.data?.results ?? [];
              return CarouselSlider.builder(
                options: CarouselOptions(
                  viewportFraction: 0.5,
                  aspectRatio: 16 / 9,
                  height: MediaQuery.of(context).size.height * 0.38,
                ),
                itemCount: recommended.length,
                itemBuilder: (context, i, realIndex) {
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
                                "https://image.tmdb.org/t/p/w200${recommended[i].posterPath}" ??
                                    "",
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.23,
                                fit: BoxFit.fill,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                MovieCardModel moviemodel = MovieCardModel(
                                    isSelected: true,
                                    id: recommended[i].id.toString() ?? "",
                                    image: recommended[i].posterPath ?? "",
                                    title: recommended[i].title ?? '',
                                    year: recommended[i]
                                            .releaseDate
                                            ?.substring(0, 4) ??
                                        "",
                                    additional:
                                        recommended[i].originalTitle ?? "");
                                FireBaseFunctions.addmovie(moviemodel);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    topLeft: Radius.circular(4),
                                  ),
                                  color: Color.fromARGB(230, 81, 79, 79),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
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
                              "  ${recommended[i].voteAverage}" ?? "",
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
                              recommended[i].title ?? '',
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
                            recommended[i].releaseDate?.substring(0, 10) ?? "",
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
