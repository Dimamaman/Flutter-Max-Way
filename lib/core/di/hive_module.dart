

import 'package:flutter_max_way/core/hive/hive.dart';
import 'package:flutter_max_way/presenter/screens/details/details_bloc.dart';
import 'package:flutter_max_way/presenter/utils/navigator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../hive/database/database.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpDatabase() async {
  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();

  getIt.registerLazySingleton<AppDatabase>(() => database);

}
