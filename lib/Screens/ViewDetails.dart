import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/movieTypeBox.dart';

import '../Apis/ApiManager.dart';

class ViewDetails extends StatelessWidget {
  static const String routeName = "view";

  ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments as dynamic;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder(
            future: ApiManager.getdetails(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error!',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
              var title = snapshot.data?.title ?? "";
              var image = snapshot.data?.posterPath ?? "";
              var date = snapshot.data?.releaseDate ?? "";
              var type = snapshot.data?.genres; //not Complete
              var brief = snapshot.data?.overview ?? "";
              var rating = snapshot.data?.voteAverage;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Image.network(
                    "https://image.tmdb.org/t/p/w500$image",
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500$image",
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  width: 27,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(4),
                                          topLeft: Radius.circular(4)),
                                      color: Color(0xff514F4F)),
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Movietypebox(),
                                  SizedBox(
                                    height: 7.0,
                                  ),
                                  Text(
                                    brief,
                                    style: TextStyle(
                                      color: Color(0xffcbcbcb),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Color(0xffFFBB3B),
                                        size: 35,
                                      ),
                                      Text(
                                        rating.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
