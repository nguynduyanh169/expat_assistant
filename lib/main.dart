import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/cubits/authentication_cubit.dart';
import 'package:expat_assistant/src/models/auth_status.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/route.dart';
import 'package:expat_assistant/src/states/authentication_state.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter<LessonLocal>(LessonLocalAdapter());
  Hive.registerAdapter<ConversationLocal>(ConversationLocalAdapter());
  Hive.registerAdapter<LessonFileLocal>(LessonFileLocalAdapter());
  Hive.registerAdapter<VocabularyLocal>(VocabularyLocalAdapter());
  await Hive.openBox(HiveBoxName.USER_AUTH);
  await Hive.openBox(HiveBoxName.LESSON_SRC);
  await Hive.openBox(HiveBoxName.LESSON);
  await Hive.openBox(HiveBoxName.CONVERSATION);
  await Hive.openBox(HiveBoxName.VOCABULARY);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void dispose() {
    Hive.close();
    EventBusUtils.instance.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..checkLoggedIn(),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state.status.isAuthenticated) {
            isLoggedIn = true;
          } else if (state.status.isUnauthenticated) {
            isLoggedIn = false;
          }
          return MaterialApp(
            title: 'HCMC expat assistant',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            routes: routes,
            initialRoute:
                isLoggedIn == true ? RouteName.HOME_PAGE : RouteName.LOGIN,
          );
        },
      ),
    );
  }
}
