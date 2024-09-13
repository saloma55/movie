import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Apis/ApiManager.dart';
import 'package:movies/Models/movie_card_model.dart';

import 'movie_item.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchController = TextEditingController();
  List<dynamic> searchResults = []; // Store search results
  bool isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();

    // Listen to changes in the search query
    searchController.addListener(() {
      _performSearch(); // Call the search function on text change
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  // Method to perform the API search
  void _performSearch() async {
    String query = searchController.text.trim(); // Get the input query

    if (query.isEmpty) {
      setState(() {
        searchResults = []; // Clear results if the query is empty
      });
      return;
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      var response =
          await ApiManager.getSearchResults(query); // Make the API call
      setState(() {
        searchResults = response.results ?? []; // Update the search results
      });
    } catch (e) {
      print('Error during search: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
              margin: EdgeInsets.only(top: 40.0,),
              decoration: BoxDecoration(
                color: Color(0xff282A28),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xff514F4F), width: 2),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white, size: 30),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Color(0xff514F4F), fontSize: 20),
                ),
                style:
                    TextStyle(color: Colors.white), // Add this for white text
              ),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            // Show loader while fetching results
            Expanded(
              child: searchResults.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/search-remove.png",
                              height: MediaQuery.of(context).size.height * 0.1),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'No movies found',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
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
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          var movie = searchResults[index];
                          return MovieItem(
                              movieCardModel: MovieCardModel(
                                  image:
                                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                  title: movie.title,
                                  year: movie.releaseDate,
                                  additional: movie.originalTitle));
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
