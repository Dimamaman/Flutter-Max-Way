import 'package:floor/floor.dart';
import 'package:flutter_max_way/core/floor/entity/address.dart';
import 'package:flutter_max_way/core/floor/entity/product_data.dart';

@dao
abstract class AddressDao {

  @Query('SELECT * FROM address')
  Future<List<Address>> getAllAddress();

  @Query('SELECT * FROM address WHERE id = :id')
  Stream<Address?> findAddressById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAddress(Address address);

}