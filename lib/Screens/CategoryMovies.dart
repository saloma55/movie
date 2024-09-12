import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Apis/ApiManager.dart';
import 'package:movies/Models/category_model.dart';
import 'package:movies/Models/movie_card_model.dart';
import 'package:movies/Screens/movie_item.dart';

class CategoryMovies extends StatelessWidget {
  static const String routeName = "category";

  const CategoryMovies({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryModel =
        ModalRoute.of(context)?.settings.arguments as CategoryModel;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          categoryModel.type,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiManager.categoryfilter(categoryModel.id),
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
                    color: Colors.red),
              ),
            );
          }
          var filter = snapshot.data?.results ?? [];
          return ListView.separated(
            itemCount: filter.length,
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
                        "https://image.tmdb.org/t/p/w500${filter[index].posterPath ?? ""}",
                    title: filter[index].title ?? "",
                    year: filter[index].releaseDate?.substring(0, 4) ?? "",
                    additional: filter[index].originalTitle ?? ""),
              );
            },
          );
        },
      ),
    );
  }
}
