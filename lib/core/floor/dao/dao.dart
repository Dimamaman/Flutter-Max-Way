import 'package:floor/floor.dart';
import 'package:flutter_max_way/core/floor/entity/product_data.dart';


@dao
abstract class ProductDao {
  @Query('SELECT * FROM ProductData')
  Future<List<ProductData>> getAllProducts();

  @Query('SELECT * FROM ProductData WHERE id = :id')
  Stream<ProductData?> findProductById(String id);

  @Query('SELECT * FROM ProductData')
  Stream<List<ProductData>> streamedData();

  @insert
  Future<void> insertProduct(ProductData product);

  @Query('DELETE FROM ProductData where id = :id')
  Future<void> deleteTodo(String id);

  @delete
  Future<int> deleteAll(List<ProductData> list);
}