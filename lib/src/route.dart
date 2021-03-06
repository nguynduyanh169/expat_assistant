import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/screens/VNlearn_screen.dart';
import 'package:expat_assistant/src/screens/blog_details_screen.dart';
import 'package:expat_assistant/src/screens/blogs_screen.dart';
import 'package:expat_assistant/src/screens/call_room_screen.dart';
import 'package:expat_assistant/src/screens/calling_screen.dart';
import 'package:expat_assistant/src/screens/change_password_screen.dart';
import 'package:expat_assistant/src/screens/channel_screen.dart';
import 'package:expat_assistant/src/screens/conversation_details_screen.dart';
import 'package:expat_assistant/src/screens/edit_profile_screen.dart';
import 'package:expat_assistant/src/screens/event_details_screen.dart';
import 'package:expat_assistant/src/screens/events_screen.dart';
import 'package:expat_assistant/src/screens/feedback_call_screen.dart';
import 'package:expat_assistant/src/screens/finish_screen.dart';
import 'package:expat_assistant/src/screens/food_camera_screen.dart';
import 'package:expat_assistant/src/screens/forget_password_screen.dart';
import 'package:expat_assistant/src/screens/home_page.dart';
import 'package:expat_assistant/src/screens/home_screen.dart';
import 'package:expat_assistant/src/screens/invoice_screen.dart';
import 'package:expat_assistant/src/screens/loading_indicator_screen.dart';
import 'package:expat_assistant/src/screens/login_screen.dart';
import 'package:expat_assistant/src/screens/map_screen.dart';
import 'package:expat_assistant/src/screens/notification_screen.dart';
import 'package:expat_assistant/src/screens/payment_done_screen.dart';
import 'package:expat_assistant/src/screens/practice_conversation_screen.dart';
import 'package:expat_assistant/src/screens/practice_vocabulary_screen.dart';
import 'package:expat_assistant/src/screens/profile_screen.dart';
import 'package:expat_assistant/src/screens/restaurant_by_food_screen.dart';
import 'package:expat_assistant/src/screens/restaurant_details_screen.dart';
import 'package:expat_assistant/src/screens/restaurants_screen.dart';
import 'package:expat_assistant/src/screens/sign_up_screen.dart';
import 'package:expat_assistant/src/screens/specialist_details_screen.dart';
import 'package:expat_assistant/src/screens/specialists_filter_screen.dart';
import 'package:expat_assistant/src/screens/specialists_screen.dart';
import 'package:expat_assistant/src/screens/upcoming_appointment_screen.dart';
import 'package:expat_assistant/src/screens/utilities_screen.dart';
import 'package:expat_assistant/src/screens/vocabulary_details_screen.dart';
import 'package:expat_assistant/src/screens/wallet_screen.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  RouteName.HOME_PAGE: (BuildContext context) => new HomePage(),
  RouteName.LOGIN: (BuildContext context) => new LoginScreen(),
  RouteName.HOME_SCREEN: (BuildContext context) => new HomeScreen(),
  RouteName.RESTAURANTS: (BuildContext context) => new RestaurantsScreen(),
  RouteName.RESTAURANT_DETAILS: (BuildContext context) =>
      new RestaurantDetailsScreen(),
  RouteName.EVENTS: (BuildContext context) => new EventsScreen(),
  RouteName.VIETNAMESE_LEARN: (BuildContext context) => new VNlearnScreen(),
  RouteName.SPECIALISTS: (BuildContext context) => new SpecialistsScreen(),
  RouteName.EVENT_DETAILS: (BuildContext context) => new EventDetailsScreen(),
  RouteName.CONVERSATION_DETAILS: (BuildContext context) =>
      new ConversationDetailScreen(),
  RouteName.VOCABULARY_DETAILS: (BuildContext context) =>
      new VocabularyDetailScreen(),
  RouteName.PRACTICE_VOCABULARY: (BuildContext context) =>
      new PracticeVocabularyScreen(),
  RouteName.UTILS: (BuildContext context) => new UtilitiesScreen(),
  RouteName.BLOGS: (BuildContext context) => new BlogsScreen(),
  RouteName.MAP: (BuildContext context) => new MapScreen(),
  RouteName.BLOG_DETAILS: (BuildContext context) => new BlogDetailsScreen(),
  RouteName.FOOD_CAMERA: (BuildContext context) => new FoodCameraScreen(),
  RouteName.RESTAURANTS_BY_FOOD: (BuildContext context) =>
      new RestaurantByFoodScreen(),
  RouteName.SPECIALIST_DETAILS: (BuildContext context) =>
      new SpecialistDetailsScreen(),
  RouteName.PROFILE: (BuildContext context) => new ProfileScreen(),
  RouteName.WALLET: (BuildContext context) => new WalletScreen(),
  RouteName.CHANNEL: (BuildContext context) => new ChannelScreen(),
  RouteName.SIGN_UP: (BuildContext context) => new SignUpScreen(),
  RouteName.FINISH: (BuildContext context) => new FinishScreen(),
  RouteName.PRACTICE_CONVERSATION: (BuildContext context) =>
      new PracticeConversationScreen(),
  RouteName.FINISH_CONVERSATION: (BuildContext context) =>
      new FinishScreenForConversation(),
  RouteName.NOTIFICATION: (BuildContext context) => new NotificationScreen(),
  RouteName.CALLING: (BuildContext context) => new CallingScreen(),
  RouteName.CALL_ROOM: (BuildContext context) => new CallRoomScreen(),
  RouteName.INVOICE: (BuildContext context) => new InvoiceScreen(),
  RouteName.FILTER_SPECIALIST: (BuildContext context) =>
      new SpecialistFilterScreen(),
  RouteName.UPCOMING_APPOINTMENT: (BuildContext context) =>
      new UpcomingAppointmentScreen(),
  RouteName.EDIT_PROFILE: (BuildContext context) => new EditProfileScreen(),
  RouteName.LOADING: (BuildContext context) => new LoadingIndicatorScreen(),
  RouteName.FEEDBACK: (BuildContext context) => new FeedBackScreen(),
  RouteName.PAYMENT_DONE: (BuildContext context) => new PaymentDoneScreen(),
  RouteName.CHANGE_PASSWORD: (BuildContext context) =>
      new ChangePasswordScreen(),
  RouteName.FORGET_PASSWORD: (BuildContext context) =>
      new ForgetPasswordScreen()
};
