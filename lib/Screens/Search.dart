import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Apis/ApiManager.dart';

class Search extends StatelessWidget {
  var serchquery = TextEditingController();

  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 7,
                ),
                margin: EdgeInsets.only(
                  top: 40.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff282A28),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Color(0xff514F4F),
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: serchquery,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Color(0xff514F4F),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: ApiManager.getSearchResults(serchquery.toString()),
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
                var search = snapshot.data?.results ?? [];
                return Expanded(
                  child: ListView.builder(
                    itemCount: search.length,
                    itemBuilder: (context, index) {
                      return Text(search[index].title ?? "");
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
