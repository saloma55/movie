import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Browse.dart';
import 'Home.dart';
import 'Search.dart';
import 'WatchList.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selecteditem = 0;
  List<Widget> tabs = [
    Home(),
    Search(),
    Browse(),
    WatchList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff282A28),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selecteditem,
        onTap: (value) {
          selecteditem = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w300,
        ),
        selectedLabelStyle: TextStyle(
          color: Colors.yellow,
          fontSize: 11,
          fontWeight: FontWeight.w300,
        ),
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/browseIcon.png"),
            ),
            label: 'BROWSE',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/watchListIcon.png"),
            ),
            label: 'WATCHLIST',
          ),
        ],
      ),
      body: tabs[selecteditem],
    );
  }
}
