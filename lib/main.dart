import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/main_screen.dart';
import 'package:flutter_max_way/presenter/screens/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'core/di/hive_module.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  // await setUpDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}
