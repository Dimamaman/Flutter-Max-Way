

import 'package:flutter_max_way/core/hive/hive.dart';
import 'package:flutter_max_way/presenter/screens/details/details_bloc.dart';
import 'package:flutter_max_way/presenter/utils/navigator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpDatabase() async {
  Box box;

  if(await Hive.boxExists(dbName)) {
    box = await Hive.openBox(dbName);
  } else {
    box = Hive.box(dbName);
  }

  getIt.registerLazySingleton(() => HiveHelper(box));
  getIt.registerLazySingleton(() => DetailsBloc(getIt.get()));
}
