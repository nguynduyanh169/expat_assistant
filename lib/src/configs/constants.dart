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
  static const NOTIFICATION = "/notification";
  static const TEST_CALL = "/testCall";
  static const CALLING = "/calling";
  static const CALL_ROOM = "/callRoom";
  static const INVOICE = "/invoice";
  static const FILTER_SPECIALIST = "/filterSpecialist";
  static const UPCOMING_APPOINTMENT = "/upcomingAppointment";
  static const EDIT_PROFILE = "/editProfile";
  static const LOADING = "/loading";
  static const FEEDBACK = "/feedback";
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
  static const String GET_EVENTS_BY_TITLE = BASE_URL + "/api/events/title";
  static const String GET_EVENTS_BY_EXPATID =
      BASE_URL + "/api/events/expatEvent";
  static const String JOIN_EVENT = BASE_URL + "/api/events/confirm";
  static const String UNJOIN_EVENT = BASE_URL + "/api/events/join";
  static const String GET_BLOGS = BASE_URL + "/api/blogs/blog";
  static const String GET_BLOGS_BY_PRIORITY = BASE_URL + "/api/blogs/priority";
  static const String GET_CHANNELS_STATUS = BASE_URL + "/api/channels/status";
  static const String GET_BLOGS_BY_CHANNEL = BASE_URL + "/api/blogs/channel";
  static const String GET_BLOGS_BY_TITLE = BASE_URL + "/api/blogs/title";
  static const String GET_BLOGS_BY_ID = BASE_URL + "/api/blogs/";
  static const String GET_BLOGS_BY_CATEGORYID =
      BASE_URL + "/api/blogs/category";
  static const String GET_BLOGS_BY_DATE = BASE_URL + "/api/blogs/date";
  static const String GET_SPECIALISTS_BY_RATING = BASE_URL + "/api/spec/rating";
  static const String GET_SPECIALISTS_INFO = BASE_URL + "/api/spec/";
  static const String GET_SPECIALISTS_BY_NAME = BASE_URL + "/api/spec/fullname";
  static const String GET_SPECIALISTS_BY_MAJOR = BASE_URL + "/api/spec/major";
  static const String GET_SPECIALISTS_BY_CREATEDATE =
      BASE_URL + "/api/spec/all";
  static const String GET_MAJORS = BASE_URL + "/api/majors";
  static const String SIGN_UP = BASE_URL + "/api/authen/signup";
  static const String GET_PROFILE_EXPAT = BASE_URL + "/api/authen/expat";
  static const String EDIT_PROFILE = BASE_URL + "/api/authen/";
  static const String REGISTRY_SESSION = BASE_URL + "/api/appointment/registry";
  static const String GET_APPOINTMENT_BY_EXPAT =
      BASE_URL + "/api/appointment/expat";
  static const String GET_APPOINTMENT_BY_ID = BASE_URL + "/api/appointment/";
}

class HiveBoxName {
  static const USER_AUTH = "UserAuthentication";
  static const LESSON = "VietnameseLesson";
  static const LESSON_SRC = "LessonSrc";
  static const CONVERSATION = "Conversation";
  static const VOCABULARY = "Vocabulary";
  static const USER_PROFILE = "UserProfile";
}

class AppColors {
  static const Color MAIN_COLOR = Color.fromRGBO(64, 201, 162, 1);
}

class Agora {
  static const APP_ID = "9aff35de497443c9be8469665d87176b";
  static const CHANNEL_NAME = "baobao";
  static const TOKEN =
      '0069aff35de497443c9be8469665d87176bIAATJfdYqUoExd1CNlam77/O3FDBSuHrIeXIb1xDET5Z0DuPUdkAAAAAEABYI5phRfsJYQEAAQBF+wlh';
}

class MomoConstants {
  static const PUB_KEY =
      "-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA0YrPUGX80YYdeActXHAV60SvatbOHzKbR/bQ8pjTd9iOspCPQYqcxXKcGaV3q0DozzzaQ4PJdUMdUwbcl6SnO12ayQwrdlbK0D15UNLame729uUCos0dEVqLvq/TGdEFk2O8wOxAu8w1+mqGwv4tRciSKwgBWGd6KpA+HqjdY9/Cb/0WGWPl2/ZAAzWIC7i2z6jtHYzn90VLrm8csPRM1fq7vZ7MOSXqq86qbHHs/wo9c+94Kfy2gvxCGsFbCwsrM1G4qYtOW1kKUjiK2oo4SPLQ0KRvEqlZPlUrqr6ct173f7nLfF0rp+HGaWngRiBhcdOH/MGE5YlcLmK1EuOsqUzVr1UlBlKKr9yZdqHb4NrfK327ch2nyoU2Jr71VXWzzcI6zyZZxM2DcIC7f+uji2hJFdy6wCEKdWkD4KF8DWD7+qn1QcaTep/Q+XCAg8F9QZhx/oNN1xSeBmrRRwLudcwoUv9Q12QHHj8SNhbv6ARnxMTQ6eHCAFXDPCg0dslyx+yNo9K6QBgecv25L5vBFS9v8JS1gkn3gtU6DrogGUMlea+h+vwvDw4AKJdGc3p5bSEi5JUj9SN2qrseqpI/r6glqv7UBTEhqC+W4iDeuQaLNNNEuAIJcjDIVqmHtIHtUWDp2pJb4sGoEHxlEOwhabbCs1my9Mn/E8/bbciomLMCAwEAAQ==\n-----END PUBLIC KEY-----";
}
