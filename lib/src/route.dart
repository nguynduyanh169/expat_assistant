import 'package:expat_assistant/src/screens/VNlearn_screen.dart';
import 'package:expat_assistant/src/screens/assistant_screen.dart';
import 'package:expat_assistant/src/screens/blog_details_screen.dart';
import 'package:expat_assistant/src/screens/blogs_screen.dart';
import 'package:expat_assistant/src/screens/conversation_details_screen.dart';
import 'package:expat_assistant/src/screens/event_details_screen.dart';
import 'package:expat_assistant/src/screens/events_screen.dart';
import 'package:expat_assistant/src/screens/home_page.dart';
import 'package:expat_assistant/src/screens/home_screen.dart';
import 'package:expat_assistant/src/screens/login_screen.dart';
import 'package:expat_assistant/src/screens/map_screen.dart';
import 'package:expat_assistant/src/screens/practice_vocabulary_screen.dart';
import 'package:expat_assistant/src/screens/restaurants_screen.dart';
import 'package:expat_assistant/src/screens/utilities_screen.dart';
import 'package:expat_assistant/src/screens/vocabulary_details_screen.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  '/' : (BuildContext context) => new LoginScreen(),
  '/homepage' : (BuildContext context) => new HomePage(),
  '/homescreen' : (BuildContext context) => new HomeScreen(),
  '/restaurants' : (BuildContext context) => new RestaurantsScreen(),
  '/events': (BuildContext context) => new EventsScreen(),
  '/vietnameselearns': (BuildContext context) => new VNlearnScreen(),
  '/assistants': (BuildContext context) => new AssistantScreen(),
  '/eventdetail': (BuildContext context) => new EventDetailsScreen(),
  '/conversationdetails': (BuildContext context) => new ConversationDetailScreen(),
  '/vocabularydetails': (BuildContext context) => new VocabularyDetailScreen(),
  '/practicevocabulary': (BuildContext context) => new PracticeVocabularyScreen(),
  '/utilities': (BuildContext context) => new UtilitiesScreen(),
  '/blogs': (BuildContext context) => new BlogsScreen(),
  '/map': (BuildContext context) => new MapScreen(),
  '/blogdetails': (BuildContext context) => new BlogDetailsScreen(),
};

