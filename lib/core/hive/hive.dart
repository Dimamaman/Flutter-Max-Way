
import 'package:hive/hive.dart';

import '../model/product_data.dart';

class HiveHelper {
  static const String boxName = "foods";

  Box box;

  HiveHelper(this.box);

  Future<void> addProduct(ProductData product) async {
    return await box.put(product.id, product.toJson());
  }

  Future<void> deleteProduct(ProductData product) async {
    return await box.delete(product.id);
  }

  Future<List<ProductData>> getAllProducts() async {
    return (box.values).map((e) => ProductData.fromJson(e)).toList();
  }

}