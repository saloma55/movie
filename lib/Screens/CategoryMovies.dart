import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Apis/ApiManager.dart';

import '../Models/CategoryName.dart';

class CategoryMovies extends StatelessWidget {
  static const String routeName="category";
  const CategoryMovies({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryid =ModalRoute.of(context)?.settings.arguments as dynamic ;
    return Scaffold(
      body:FutureBuilder(future: ApiManager.categoryfilter(categoryid), builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError){
          return Center(
            child: Text('Something Went Wrong !',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red

            ),),
          );
        }
        var filter =snapshot.data?.results??[];
        return Expanded(
          child: ListView.builder(
            itemCount: filter.length,
            itemBuilder: (context, index) {
            return Text(filter[index].title??'',style: TextStyle(
              color: Colors.red
            ),);
          },),
        );
      },) ,
    );
  }
}
