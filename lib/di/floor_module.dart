
import 'package:get_it/get_it.dart';
import '../core/floor/database/database.dart';


GetIt getIt = GetIt.instance;

Future<void> setUpDatabase() async {
  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();

  getIt.registerLazySingleton<AppDatabase>(() => database);

}
