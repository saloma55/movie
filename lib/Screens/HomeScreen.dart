import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Browse.dart';
import 'Home.dart';
import 'Search.dart';
import 'WatchList.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName='home';
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selecteditem=0;
  List<Widget>tabs=[
    Home(),
    Search(),
    Browse(),
    WatchList()

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff282A28),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selecteditem,
        onTap: (value){
          selecteditem=value;
          setState(() {

          });
        },

        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300
        ),
         selectedLabelStyle: TextStyle(
           color: Colors.yellow,
           fontSize: 14,
           fontWeight: FontWeight.w300
         ),
        iconSize: 24,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        backgroundColor: Colors.black,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/Browse-removebg.png")),label: 'Browse'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/washlist-removebg.png")),label: 'WatchList'),

      ]),
      body: tabs[selecteditem],
    );
  }


}
