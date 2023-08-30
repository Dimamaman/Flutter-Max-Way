
import 'package:floor/floor.dart';
import 'package:flutter_max_way/core/floor/entity/address.dart';
import 'package:flutter_max_way/core/floor/entity/product_data.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import '../dao/address_dao.dart';
import '../dao/product_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ProductData, Address])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
  AddressDao get addressDao;
}