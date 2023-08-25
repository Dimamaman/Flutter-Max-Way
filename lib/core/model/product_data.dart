
import 'package:hive/hive.dart';

import 'description_model.dart';

part 'product_data.g.dart';

@HiveType(typeId: 0)
class ProductData {
  @HiveField(0)
  String id;
  @HiveField(1)
  int price;
  @HiveField(2)
  String currency;
  @HiveField(3)
  String image;
  @HiveField(4)
  DescriptionData title;
  @HiveField(5)
  DescriptionData description;


  ProductData({
    required this.id,
    required this.price,
    required this.currency,
    required this.image,
    required this.title,
    required this.description,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] ?? '',
      price: json['out_price'] ?? 1,
      currency: json['currency'] ?? '',
      image: json['image'] ?? '',
      title: DescriptionData.fromJson(json['title'] ?? {}),
      description: DescriptionData.fromJson(json['description'] ?? {}),
    );
  }

  Map<String,dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['price'] = price;
    map['currency'] = currency;
    map['image'] = image;
    map['title'] = title;
    map['description'] = description;

    return map;
  }
}

