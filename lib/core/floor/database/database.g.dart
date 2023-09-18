// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  AddressDao? _addressDaoInstance;

  OrderDao? _orderDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductData` (`productId` TEXT NOT NULL, `price` INTEGER NOT NULL, `currency` TEXT NOT NULL, `image` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `amount` INTEGER NOT NULL, PRIMARY KEY (`productId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `address` (`lat` REAL NOT NULL, `long` REAL NOT NULL, `locationName` TEXT NOT NULL, `entrance` TEXT NOT NULL, `floor` TEXT NOT NULL, `flat` TEXT NOT NULL, `addressName` TEXT NOT NULL, PRIMARY KEY (`lat`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderEntity` (`orderNo` INTEGER NOT NULL, `branch` TEXT NOT NULL, `time` TEXT NOT NULL, `date` TEXT NOT NULL, `payment` TEXT NOT NULL, `products` TEXT NOT NULL, `price` INTEGER NOT NULL, `address` TEXT NOT NULL, `delivery` TEXT, `scheduledTime` TEXT, `isCompleted` INTEGER NOT NULL, PRIMARY KEY (`orderNo`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  AddressDao get addressDao {
    return _addressDaoInstance ??= _$AddressDao(database, changeListener);
  }

  @override
  OrderDao get orderDao {
    return _orderDaoInstance ??= _$OrderDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _productDataInsertionAdapter = InsertionAdapter(
            database,
            'ProductData',
            (ProductData item) => <String, Object?>{
                  'productId': item.productId,
                  'price': item.price,
                  'currency': item.currency,
                  'image': item.image,
                  'title': item.title,
                  'description': item.description,
                  'amount': item.amount
                },
            changeListener),
        _productDataUpdateAdapter = UpdateAdapter(
            database,
            'ProductData',
            ['productId'],
            (ProductData item) => <String, Object?>{
                  'productId': item.productId,
                  'price': item.price,
                  'currency': item.currency,
                  'image': item.image,
                  'title': item.title,
                  'description': item.description,
                  'amount': item.amount
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductData> _productDataInsertionAdapter;

  final UpdateAdapter<ProductData> _productDataUpdateAdapter;

  @override
  Future<List<ProductData>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM ProductData',
        mapper: (Map<String, Object?> row) => ProductData(
            productId: row['productId'] as String,
            price: row['price'] as int,
            currency: row['currency'] as String,
            image: row['image'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            amount: row['amount'] as int));
  }

  @override
  Stream<ProductData?> findProductById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM ProductData WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductData(
            productId: row['productId'] as String,
            price: row['price'] as int,
            currency: row['currency'] as String,
            image: row['image'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            amount: row['amount'] as int),
        arguments: [id],
        queryableName: 'ProductData',
        isView: false);
  }

  @override
  Stream<List<ProductData>> streamedData() {
    return _queryAdapter.queryListStream('SELECT * FROM ProductData',
        mapper: (Map<String, Object?> row) => ProductData(
            productId: row['productId'] as String,
            price: row['price'] as int,
            currency: row['currency'] as String,
            image: row['image'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            amount: row['amount'] as int),
        queryableName: 'ProductData',
        isView: false);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ProductData where productId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ProductData');
  }

  @override
  Future<void> insertProduct(ProductData product) async {
    await _productDataInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProduct(ProductData productData) async {
    await _productDataUpdateAdapter.update(
        productData, OnConflictStrategy.abort);
  }
}

class _$AddressDao extends AddressDao {
  _$AddressDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _addressInsertionAdapter = InsertionAdapter(
            database,
            'address',
            (Address item) => <String, Object?>{
                  'lat': item.lat,
                  'long': item.long,
                  'locationName': item.locationName,
                  'entrance': item.entrance,
                  'floor': item.floor,
                  'flat': item.flat,
                  'addressName': item.addressName
                },
            changeListener),
        _addressDeletionAdapter = DeletionAdapter(
            database,
            'address',
            ['lat'],
            (Address item) => <String, Object?>{
                  'lat': item.lat,
                  'long': item.long,
                  'locationName': item.locationName,
                  'entrance': item.entrance,
                  'floor': item.floor,
                  'flat': item.flat,
                  'addressName': item.addressName
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Address> _addressInsertionAdapter;

  final DeletionAdapter<Address> _addressDeletionAdapter;

  @override
  Future<List<Address>> getAllAddress() async {
    return _queryAdapter.queryList('SELECT * FROM address',
        mapper: (Map<String, Object?> row) => Address(
            lat: row['lat'] as double,
            long: row['long'] as double,
            locationName: row['locationName'] as String,
            entrance: row['entrance'] as String,
            floor: row['floor'] as String,
            flat: row['flat'] as String,
            addressName: row['addressName'] as String));
  }

  @override
  Stream<Address?> findAddressById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM address WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Address(
            lat: row['lat'] as double,
            long: row['long'] as double,
            locationName: row['locationName'] as String,
            entrance: row['entrance'] as String,
            floor: row['floor'] as String,
            flat: row['flat'] as String,
            addressName: row['addressName'] as String),
        arguments: [id],
        queryableName: 'address',
        isView: false);
  }

  @override
  Stream<List<Address>> streamedData() {
    return _queryAdapter.queryListStream('SELECT * FROM address',
        mapper: (Map<String, Object?> row) => Address(
            lat: row['lat'] as double,
            long: row['long'] as double,
            locationName: row['locationName'] as String,
            entrance: row['entrance'] as String,
            floor: row['floor'] as String,
            flat: row['flat'] as String,
            addressName: row['addressName'] as String),
        queryableName: 'address',
        isView: false);
  }

  @override
  Future<void> insertAddress(Address address) async {
    await _addressInsertionAdapter.insert(address, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAddress(Address address) async {
    await _addressDeletionAdapter.delete(address);
  }
}

class _$OrderDao extends OrderDao {
  _$OrderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _orderEntityInsertionAdapter = InsertionAdapter(
            database,
            'OrderEntity',
            (OrderEntity item) => <String, Object?>{
                  'orderNo': item.orderNo,
                  'branch': item.branch,
                  'time': item.time,
                  'date': item.date,
                  'payment': item.payment,
                  'products': item.products,
                  'price': item.price,
                  'address': item.address,
                  'delivery': item.delivery,
                  'scheduledTime': item.scheduledTime,
                  'isCompleted': item.isCompleted ? 1 : 0
                },
            changeListener),
        _orderEntityUpdateAdapter = UpdateAdapter(
            database,
            'OrderEntity',
            ['orderNo'],
            (OrderEntity item) => <String, Object?>{
                  'orderNo': item.orderNo,
                  'branch': item.branch,
                  'time': item.time,
                  'date': item.date,
                  'payment': item.payment,
                  'products': item.products,
                  'price': item.price,
                  'address': item.address,
                  'delivery': item.delivery,
                  'scheduledTime': item.scheduledTime,
                  'isCompleted': item.isCompleted ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderEntity> _orderEntityInsertionAdapter;

  final UpdateAdapter<OrderEntity> _orderEntityUpdateAdapter;

  @override
  Future<List<OrderEntity>> getAllCurrentOrders() async {
    return _queryAdapter.queryList(
        'SELECT * FROM OrderEntity where isCompleted = 0',
        mapper: (Map<String, Object?> row) => OrderEntity(
            orderNo: row['orderNo'] as int,
            branch: row['branch'] as String,
            time: row['time'] as String,
            date: row['date'] as String,
            payment: row['payment'] as String,
            products: row['products'] as String,
            price: row['price'] as int,
            address: row['address'] as String,
            isCompleted: (row['isCompleted'] as int) != 0));
  }

  @override
  Stream<List<OrderEntity>> streamedDataCurrent() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM OrderEntity where isCompleted = 0',
        mapper: (Map<String, Object?> row) => OrderEntity(
            orderNo: row['orderNo'] as int,
            branch: row['branch'] as String,
            time: row['time'] as String,
            date: row['date'] as String,
            payment: row['payment'] as String,
            products: row['products'] as String,
            price: row['price'] as int,
            address: row['address'] as String,
            isCompleted: (row['isCompleted'] as int) != 0),
        queryableName: 'OrderEntity',
        isView: false);
  }

  @override
  Future<List<OrderEntity>> getAllHistoryOrders() async {
    return _queryAdapter.queryList(
        'SELECT * FROM OrderEntity where isCompleted = 1',
        mapper: (Map<String, Object?> row) => OrderEntity(
            orderNo: row['orderNo'] as int,
            branch: row['branch'] as String,
            time: row['time'] as String,
            date: row['date'] as String,
            payment: row['payment'] as String,
            products: row['products'] as String,
            price: row['price'] as int,
            address: row['address'] as String,
            isCompleted: (row['isCompleted'] as int) != 0));
  }

  @override
  Stream<List<OrderEntity>> streamedDataHistory() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM OrderEntity where isCompleted = 1',
        mapper: (Map<String, Object?> row) => OrderEntity(
            orderNo: row['orderNo'] as int,
            branch: row['branch'] as String,
            time: row['time'] as String,
            date: row['date'] as String,
            payment: row['payment'] as String,
            products: row['products'] as String,
            price: row['price'] as int,
            address: row['address'] as String,
            isCompleted: (row['isCompleted'] as int) != 0),
        queryableName: 'OrderEntity',
        isView: false);
  }

  @override
  Future<void> insertOrder(OrderEntity order) async {
    await _orderEntityInsertionAdapter.insert(
        order, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateOrder(OrderEntity order) async {
    await _orderEntityUpdateAdapter.update(order, OnConflictStrategy.abort);
  }
}
