import 'dart:ui';

class RouteName {
  static const RESTAURANTS_BY_FOOD = "/restaurantsFood";
  static const SPECIALISTS = "/specialists";
  static const SPECIALIST_DETAILS = "/specialistDetails";
  static const EVENTS = "/events";
  static const EVENT_DETAILS = "/eventDetail";
  static const BLOG_DETAILS = "/blogDetails";
  static const PROFILE = "/profile";
  static const WALLET = "/wallet";
  static const HOME_PAGE = "/";
  static const LOGIN = "/login";
  static const UTILS = "/utilities";
  static const BLOGS = "/blogs";
  static const CHANNEL = "/channel";
  static const SIGN_UP = "/signUp";
  static const HOME_SCREEN = "/homeScreen";
  static const RESTAURANTS = "/restaurants";
  static const RESTAURANT_DETAILS = "/restaurantsDetail";
  static const VIETNAMESE_LEARN = "/vietnameseLearns";
  static const CONVERSATION_DETAILS = "/conversationDetails";
  static const VOCABULARY_DETAILS = "/vocabularyDetails";
  static const PRACTICE_VOCABULARY = "/practiceVocabulary";
  static const PRACTICE_CONVERSATION = "/practiceConversation";
  static const MAP = "/map";
  static const FOOD_CAMERA = "/foodCamera";
  static const FINISH = "/finish";
  static const FINISH_CONVERSATION = "/finishConversation";
}

class ApiName {
  static const String BASE_URL = "https://hcmc.herokuapp.com";
  static const String LOGIN_API = BASE_URL + "/api/authen/login";
  static const String FIND_ALL_TOPICS = BASE_URL + "/api/topic/topics";
  static const String FIND_CONVERSATION_BY_TOPIC_ID =
      BASE_URL + "/api/conversation";
  static const String FIND_VOCABULARIES_BY_TOPIC_ID =
      BASE_URL + "/api/vocabulary";
  static const String GET_EVENTS_PAGINGATION = BASE_URL + "/api/events/event/";
  static const String GET_LOCATIONS_BY_EVENTID = BASE_URL + "/api/location/";
  static const String GET_TOPICS_BY_EVENTID = BASE_URL + "/api/topic/";
  static const String GET_EVENT_CONTENT_BY_ID = BASE_URL + "/api/events/";
  static const String GET_EVENTS_BY_TITLE = BASE_URL + "/api/events/title/";
}

class HiveBoxName {
  static const USER_AUTH = "UserAuthentication";
  static const LESSON = "VietnameseLesson";
  static const LESSON_SRC = "LessonSrc";
  static const CONVERSATION = "Conversation";
  static const VOCABULARY = "Vocabulary";
}

class AppColors {
  static const Color MAIN_COLOR = Color.fromRGBO(64, 201, 162, 1);
}
