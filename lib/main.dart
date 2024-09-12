import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/Screens/HomeScreen.dart';
import 'package:movies/Screens/ViewDetails.dart';
import 'Screens/CategoryMovies.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        CategoryMovies.routeName: (context) => CategoryMovies(),
        ViewDetails.routeName: (context) => ViewDetails(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
