
import 'package:hive/hive.dart';

import '../model/product_data.dart';

class HiveHelper {

  final Box _box;

  HiveHelper(this._box);

  Future<void> addProduct(ProductData product) async {
    await _box.add(product);
  }

  ProductData? _readProduct(int key) {
    final item = _box.get(key);
    return item;
  }

  Future<void> updateItem(int itemKey, ProductData item) async {
    await _box.put(itemKey, item);
  }

  Future<void> deleteProduct(String product) async {
    // return await _box.delete(product.id);
    await _box.delete(product);
  }

  Future<List<ProductData>> getAllProducts() async {
    return (_box.values).map((e) => ProductData.fromJson(e as Map<String, dynamic>)).toList();
  }

}