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

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProduct(ProductData product);

  @Query('DELETE FROM ProductData where productId = :id')
  Future<void> deleteTodo(String id);

  @Query('DELETE FROM ProductData')
  Future<void> deleteAll();
}