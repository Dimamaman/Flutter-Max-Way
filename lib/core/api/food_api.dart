
import 'package:dio/dio.dart';
import 'package:flutter_max_way/core/model/branch_model.dart';
import 'package:flutter_max_way/core/model/model.dart';

class FoodApi {
  final _api = Dio(BaseOptions(baseUrl: "https://run.mocky.io/v3/",validateStatus: (status) => true));

  Future<List<Category>> getProducts() async {
    final response = await _api.get('1084bc88-24e4-4d5f-8b1e-e148136f157f');
    return (response.data['categories'] as List).map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Branch>> getBranches() async {
    final response = await _api.get('399c68cd-ff7b-458f-ba30-a7a1ad39c0d8');
    return (response.data['branches'] as List).map((e) => Branch.fromJson(e)).toList();
  }
}