
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Models/Poster.dart';

import '../Models/MovieDetails.dart';
import '../Models/NewRelease.dart';
import '../Models/Recommended.dart';

class ApiManager{
  static const Map<String, String> headers = {
    "Authorization":
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZTU2Yzg2MzZiOTExOTBhMDdkNmExOWM5OWYyMDgzYyIsInN1YiI6IjY1NDE1Yzg3YjY4NmI5MDBlMTE4MDg1YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.45qrNJVRNiUMtYid_qmIp5kKJ_Q0Obk-yRRywYsGgP8",
    "accept": "application/json"
  };


 static Future<Poster> getposter() async {
    var url = Uri.https("api.themoviedb.org", "3/movie/popular", {
      "language": "en-US",
      "page": "1",
    });

    var response = await http.get(url, headers: headers);
    var jsonFile = jsonDecode(response.body);
    var popularResponse = Poster.fromJson(jsonFile);
    return popularResponse;
  }

  static Future<NewRelease> getsnewreleases()async{
   Uri url=Uri.https("api.themoviedb.org","/3/movie/upcoming",{
     "language": "en-US",
     "page": "1",
   });
  http.Response response =await http.get(url,headers: headers);
   Map<String,dynamic>json=jsonDecode(response.body);
   NewRelease newRelease =NewRelease.fromJson(json);
   return newRelease;

  }

  static Future<Recommended> getrecommend()async{
    Uri url=Uri.https("api.themoviedb.org","/3/movie/top_rated",{
      "language": "en-US",
      "page": "1",
    });
    http.Response response =await http.get(url,headers: headers);
    Map<String,dynamic>json=jsonDecode(response.body);
    Recommended recommended =Recommended.fromJson(json);
    return recommended;

  }


  static Future<MovieDetails> getdetails(num movie_id)async{
   Uri url =Uri.https("api.themoviedb.org","/3/movie/${movie_id}",{
     "language":"en-US"
   });
   http.Response response = await http.get(url,headers: headers);
   Map<String ,dynamic> json =jsonDecode(response.body);
   MovieDetails movieDetails = MovieDetails.fromJson(json);
   return movieDetails;

  }


}