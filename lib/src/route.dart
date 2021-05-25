import 'package:expat_assistant/src/screens/VNlearn_screen.dart';
import 'package:expat_assistant/src/screens/assistant_screen.dart';
import 'package:expat_assistant/src/screens/event_details.dart';
import 'package:expat_assistant/src/screens/events_screen.dart';
import 'package:expat_assistant/src/screens/home_page.dart';
import 'package:expat_assistant/src/screens/home_screen.dart';
import 'package:expat_assistant/src/screens/login_screen.dart';
import 'package:expat_assistant/src/screens/restaurants_screen.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  '/' : (BuildContext context) => new LoginScreen(),
  '/homepage' : (BuildContext context) => new HomePage(),
  '/homescreen' : (BuildContext context) => new HomeScreen(),
  '/restaurantsscreen' : (BuildContext context) => new RestaurantsScreen(),
  '/eventsscreen': (BuildContext context) => new EventsScreen(),
  '/vietnameselearnscreen': (BuildContext context) => new VNlearnScreen(),
  '/assistantscreen': (BuildContext context) => new AssistantScreen(),
  '/eventdetail': (BuildContext context) => new EventDetails(),
};