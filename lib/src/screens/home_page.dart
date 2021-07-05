import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/screens/events_screen.dart';
import 'package:expat_assistant/src/screens/home_screen.dart';
import 'package:expat_assistant/src/screens/profile_screen.dart';
import 'package:expat_assistant/src/screens/restaurants_screen.dart';
import 'package:expat_assistant/src/widgets/FAB_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Widget> pageList = [];
  PageController _pageController;

  @override
  void initState() {
    pageList.add(HomeScreen());
    pageList.add(RestaurantsScreen());
    pageList.add(EventsScreen());
    pageList.add(ProfileScreen());
    _pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTappedBar(int i) {
    setState(() {
      currentIndex = i;
      _pageController.jumpToPage(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pageList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.black12)),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, RouteName.UTILS);
        },
        tooltip: 'Services',
        elevation: 0,
        child: new Icon(Ionicons.file_tray_full_outline, color: Colors.black54,),
      ),
      bottomNavigationBar: FABBottomAppBar(
        
        notchedShape: CircularNotchedRectangle(),
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
          FABBottomAppBarItem(
              iconData: Ionicons.fast_food_outline, text: 'Food'),
          FABBottomAppBarItem(
              iconData: Ionicons.calendar_outline, text: 'Event'),
          FABBottomAppBarItem(
              iconData: Ionicons.person_outline, text: 'Profile')
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
