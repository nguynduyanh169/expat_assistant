import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/route.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  await Hive.openBox(HiveBoxName.USER_AUTH);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  String initRoute = RouteName.LOGIN;
  HiveUtils _hiveUtils = HiveUtils();

  @override
  void initState() {
    bool checkLoggedIn = _hiveUtils.haveToken(boxName: HiveBoxName.USER_AUTH);
    if(checkLoggedIn == true){
      initRoute = RouteName.HOME_PAGE;
    }
    super.initState();
  }
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}

