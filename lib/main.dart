import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/cubits/authentication_cubit.dart';
import 'package:expat_assistant/src/models/auth_status.dart';
import 'package:expat_assistant/src/route.dart';
import 'package:expat_assistant/src/states/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  await Hive.openBox(HiveBoxName.USER_AUTH);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initRoute;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..checkLoggedIn(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state.status.isAuthenticated) {
            initRoute = RouteName.HOME_PAGE;
          } else if (state.status.isUnauthenticated) {
            initRoute = RouteName.LOGIN;
          }
        },
        builder: (context, state) {
          if (state.status.isAuthenticated) {
            initRoute = RouteName.HOME_PAGE;
          } else if (state.status.isUnauthenticated) {
            initRoute = RouteName.LOGIN;
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
            initialRoute: initRoute,
          );
        },
      ),
    );
  }
}
