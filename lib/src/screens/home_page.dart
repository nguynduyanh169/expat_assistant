
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/screens/events_screen.dart';
import 'package:expat_assistant/src/screens/home_screen.dart';
import 'package:expat_assistant/src/screens/profile_screen.dart';
import 'package:expat_assistant/src/screens/restaurants_screen.dart';
import 'package:expat_assistant/src/screens/utilities_screen.dart';
import 'package:expat_assistant/src/widgets/FAB_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  Widget pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return HomeScreen(changeTab: onTappedBar,);
        }
      case 1:
        {
          return RestaurantsScreen();
        }
      case 2:
        {
          return EventsScreen();
        }
      case 3:
        {
          return ProfileScreen();
        }
    }
  }

  void onTappedBar(int i) {
    setState(() {
      currentIndex = i;
    });
    // if(i != 2) {
    //   setState(() {
    //     currentIndex = i;
    //   });
    // }else{
    //   Navigator.pushNamed(context, '/restaurants');
    // }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pageCaller(currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color.fromRGBO(64, 201, 162, 1),
        onPressed: () {
          Navigator.pushNamed(context, RouteName.UTILS);
        },
        tooltip: 'Services',
        elevation: 0,
        child: new Icon(Ionicons.file_tray_full_outline),
      ),
      bottomNavigationBar: FABBottomAppBar(
        notchedShape: CircularNotchedRectangle(
        ),
        centerItemText: 'Services',
        //backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        backgroundColor: Colors.white,
        color: Colors.black54,
        selectedColor: Color.fromRGBO(64, 201, 162, 30),
        onTabSelected: (int i) {
          onTappedBar(i);
        },
        items: [
          FABBottomAppBarItem(
            text: 'Home',
            iconData: Ionicons.home_outline,
          ),
          FABBottomAppBarItem(iconData: Ionicons.fast_food_outline, text: 'Food'),
          FABBottomAppBarItem(iconData: Ionicons.calendar_outline, text: 'Event'),
          FABBottomAppBarItem(iconData: Ionicons.person_outline, text: 'Profile')
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Color.fromRGBO(30, 193, 194, 30),
      //   currentIndex: currentIndex,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (int i){
      //     onTappedBar(i);
      //   },
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white70,
      //   items: [
      //     BottomNavigationBarItem(
      //       label: 'Home',
      //       icon: Icon(LineIcons.home),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(LineIcons.headset),
      //       label: 'Ask'
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(LineIcons.calendarAlt),
      //       label: 'Event'
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(LineIcons.book),
      //       label: 'Learn VN'
      //     )
      //   ],
      // ),
      // bottomNavigationBar: ConvexAppBar(
      //   backgroundColor: Color.fromRGBO(30, 193, 194, 30),
      //   items: [
      //     TabItem(icon: LineIcons.home, title: 'Home'),
      //     TabItem(icon: LineIcons.headset, title: 'Assistant'),
      //     TabItem(icon: LineIcons.hamburger, title: 'Restaurant'),
      //     TabItem(icon: LineIcons.calendarAlt, title: 'Event'),
      //     TabItem(icon: LineIcons.book, title: 'Learn VN'),
      //   ],
      //   style: TabStyle.fixedCircle,
      //   initialActiveIndex: currentIndex,
      //   //optional, default as 0
      //   onTap: (int i) {
      //     onTappedBar(i);
      //   },
      // ),
    );
  }
}
