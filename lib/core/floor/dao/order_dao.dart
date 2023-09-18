
import 'package:floor/floor.dart';
import 'package:flutter_max_way/core/floor/entity/order_entity.dart';

@dao
abstract class OrderDao {
  @Query('SELECT * FROM OrderEntity where isCompleted = 0')
  Future<List<OrderEntity>> getAllCurrentOrders();

  @Query('SELECT * FROM OrderEntity where isCompleted = 0')
  Stream<List<OrderEntity>> streamedDataCurrent();

  @Query('SELECT * FROM OrderEntity where isCompleted = 1')
  Future<List<OrderEntity>> getAllHistoryOrders();

  @Query('SELECT * FROM OrderEntity where isCompleted = 1')
  Stream<List<OrderEntity>> streamedDataHistory();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(OrderEntity order);

  @update
  Future<void> updateOrder(OrderEntity order);
}