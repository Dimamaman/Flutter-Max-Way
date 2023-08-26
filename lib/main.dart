import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/splash/splash_screen.dart';
import 'package:flutter_max_way/presenter/utils/navigator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'core/di/hive_module.dart';
import 'core/hive/database/database.dart';
import 'core/model/description_model.dart';
import 'core/model/product_data.dart';


final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDatabase();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: 'phone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // routes: {
      //   'phone': (context) => MyPhone(),
      //   'verify': (context) => MyVerify()
      // },
      home: const SplashScreen(),
    );
  }
}
