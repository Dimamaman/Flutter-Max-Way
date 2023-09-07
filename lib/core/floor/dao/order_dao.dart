
import 'package:floor/floor.dart';
import 'package:flutter_max_way/core/floor/entity/order_entity.dart';

@dao
abstract class OrderDao {

  @Query('SELECT * FROM OrderEntity')
  Future<List<OrderEntity>> getAllOrders();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(OrderEntity order);

  @Query('SELECT * FROM OrderEntity')
  Stream<List<OrderEntity>> streamedData();

}