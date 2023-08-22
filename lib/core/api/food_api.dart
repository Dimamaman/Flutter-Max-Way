
import 'package:dio/dio.dart';
import 'package:flutter_max_way/core/model/model.dart';

class FoodApi {
  final _api = Dio(BaseOptions(baseUrl: "https://run.mocky.io/v3/",validateStatus: (status) => true));

  Future<List<Category>> getProducts() async {
    final response = await _api.get('1084bc88-24e4-4d5f-8b1e-e148136f157f');
    return (response.data['categories'] as List).map((e) => Category.fromJson(e)).toList();
  }
}