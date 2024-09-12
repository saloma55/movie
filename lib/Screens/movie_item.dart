import 'package:flutter/material.dart';

import '../Models/movie_card_model.dart';

class MovieItem extends StatelessWidget {
  MovieCardModel movieCardModel;

  MovieItem({super.key, required this.movieCardModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.network(
            movieCardModel.image,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width * 0.4,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieCardModel.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                movieCardModel.year,
                style: TextStyle(
                  color: Color(0xffcbcbcb),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                movieCardModel.additional,
                style: TextStyle(
                  color: Color(0xffcbcbcb),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
