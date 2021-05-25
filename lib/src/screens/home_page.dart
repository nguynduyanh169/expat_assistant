import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:expat_assistant/src/screens/VNlearn_screen.dart';
import 'package:expat_assistant/src/screens/assistant_screen.dart';
import 'package:expat_assistant/src/screens/events_screen.dart';
import 'package:expat_assistant/src/screens/home_screen.dart';
import 'package:expat_assistant/src/screens/restaurants_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  int currentIndex = 2;
  List<Widget> _screens = [
    AssistantScreen(),
    EventsScreen(),
    HomeScreen(),
    RestaurantsScreen(),
    VNlearnScreen()
  ];

  void onTappedBar(int i){
    setState(() {
      currentIndex = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        items: [
          TabItem(icon: LineIcons.headset, title: 'Assistant'),
          TabItem(icon: LineIcons.calendarAlt, title: 'Event'),
          TabItem(icon: LineIcons.home, title: 'Home'),
          TabItem(icon: LineIcons.utensils, title: 'Restaurant'),
          TabItem(icon: LineIcons.book, title: 'VNlearn'),
        ],
        style: TabStyle.fixedCircle,
        initialActiveIndex: currentIndex,//optional, default as 0
        onTap: (int i) {
          onTappedBar(i);
        },
      ),
    );
  }

}