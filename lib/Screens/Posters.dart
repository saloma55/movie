import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/ViewDetails.dart';
import '../Apis/ApiManager.dart';

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
          return Center(child: CircularProgressIndicator());
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
            autoPlay: false,
            height: 300.0,
          ),
          itemCount: popularpost.length,
          itemBuilder: (context, i, realIndex) {
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
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
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
                            bottom: 10,
                            left: 110,
                          ),
                          child: Text(
                            popularpost[i].title ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                            left: 80,
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
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w200${popularpost[i].posterPath}" ??
                                  "",
                              height: 200,
                            ),
                          ),
                        ),
                        Container(
                          width: 27,
                          height: 36,
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4),
                              topLeft: Radius.circular(4),
                            ),
                            color: Color(0xff514F4F),
                          ),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ],
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
