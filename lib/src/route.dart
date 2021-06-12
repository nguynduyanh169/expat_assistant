import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/screens/VNlearn_screen.dart';
import 'package:expat_assistant/src/screens/assistant_screen.dart';
import 'package:expat_assistant/src/screens/blog_details_screen.dart';
import 'package:expat_assistant/src/screens/blogs_screen.dart';
import 'package:expat_assistant/src/screens/conversation_details_screen.dart';
import 'package:expat_assistant/src/screens/event_details_screen.dart';
import 'package:expat_assistant/src/screens/events_screen.dart';
import 'package:expat_assistant/src/screens/food_camera_screen.dart';
import 'package:expat_assistant/src/screens/home_page.dart';
import 'package:expat_assistant/src/screens/home_screen.dart';
import 'package:expat_assistant/src/screens/login_screen.dart';
import 'package:expat_assistant/src/screens/map_screen.dart';
import 'package:expat_assistant/src/screens/practice_vocabulary_screen.dart';
import 'package:expat_assistant/src/screens/restaurant_by_food_screen.dart';
import 'package:expat_assistant/src/screens/restaurant_details_screen.dart';
import 'package:expat_assistant/src/screens/restaurants_screen.dart';
import 'package:expat_assistant/src/screens/utilities_screen.dart';
import 'package:expat_assistant/src/screens/vocabulary_details_screen.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  '/' : (BuildContext context) => new LoginScreen(),
  '/homePage' : (BuildContext context) => new HomePage(),
  '/homeScreen' : (BuildContext context) => new HomeScreen(),
  '/restaurants' : (BuildContext context) => new RestaurantsScreen(),
  '/restaurantsDetail' : (BuildContext context) => new RestaurantDetailsScreen(),
  '/events': (BuildContext context) => new EventsScreen(),
  '/vietnameseLearns': (BuildContext context) => new VNlearnScreen(),
  '/assistants': (BuildContext context) => new AssistantScreen(),
  '/eventDetail': (BuildContext context) => new EventDetailsScreen(),
  '/conversationDetails': (BuildContext context) => new ConversationDetailScreen(),
  '/vocabularyDetails': (BuildContext context) => new VocabularyDetailScreen(),
  '/practiceVocabulary': (BuildContext context) => new PracticeVocabularyScreen(),
  '/utilities': (BuildContext context) => new UtilitiesScreen(),
  '/blogs': (BuildContext context) => new BlogsScreen(),
  '/map': (BuildContext context) => new MapScreen(),
  '/blogDetails': (BuildContext context) => new BlogDetailsScreen(),
  '/foodCamera': (BuildContext context) => new FoodCameraScreen(),
  RouteName.RESTAURANTS_BY_FOOD: (BuildContext context) => new RestaurantByFoodScreen(),
};

