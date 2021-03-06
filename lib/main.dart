import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/cubits/authentication_cubit.dart';
import 'package:expat_assistant/src/models/auth_status.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/route.dart';
import 'package:expat_assistant/src/states/authentication_state.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/utils/notification_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter<LessonLocal>(LessonLocalAdapter());
  Hive.registerAdapter<ConversationLocal>(ConversationLocalAdapter());
  Hive.registerAdapter<LessonFileLocal>(LessonFileLocalAdapter());
  Hive.registerAdapter<VocabularyLocal>(VocabularyLocalAdapter());
  Hive.registerAdapter<Notifications>(NotificationsAdapter());
  await Hive.openBox(HiveBoxName.USER_AUTH);
  await Hive.openBox(HiveBoxName.LESSON_SRC);
  await Hive.openBox(HiveBoxName.LESSON);
  await Hive.openBox(HiveBoxName.CONVERSATION);
  await Hive.openBox(HiveBoxName.VOCABULARY);
  await Hive.openBox(HiveBoxName.NOTIFICATION_TABLE);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = true;
  bool isLoading = false;

  @override
  void dispose() {
    Hive.close();
    EventBusUtils.instance.destroy();
    super.dispose();
  }

  @override
  void initState() {
    NotificationUtils.notificationHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..checkLoggedIn(),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state.status.isUnauthenticated) {
            isLoggedIn = false;
          } else if (state.status.isAuthenticated) {
            isLoggedIn = true;
          }
          return MaterialApp(
            title: 'HCMC expat assistant',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute:
                isLoggedIn == true ? RouteName.HOME_PAGE : RouteName.LOGIN,
            routes: routes,
          );
        },
      ),
    );
  }
}
