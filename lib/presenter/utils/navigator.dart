
import 'package:flutter/material.dart';
import 'package:flutter_max_way/main.dart';
import 'package:get_it/get_it.dart';

Future<dynamic> push(Widget widget) async {
  return await Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => widget));
}

void pop([dynamic result]) {
  Navigator.pop(navigatorKey.currentContext!,result);
}

const dbName = "products";

/*
GetIt getIt = GetIt.instance;

Future<void> setUpDatabase() async {
  Box box;

  if(await Hive.boxExists(HiveHelper.boxName)) {
    box = await Hive.openBox(HiveHelper.boxName);
  } else {
    box = await Hive.openBox(HiveHelper.boxName);
  }

  getIt.registerLazySingleton(() => HiveHelper(box));
  getIt.registerLazySingleton(() => MainBloc(getIt.get()));

}*/
