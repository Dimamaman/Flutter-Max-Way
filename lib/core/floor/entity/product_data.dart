import 'package:floor/floor.dart';

@entity
class ProductData {
  @PrimaryKey(autoGenerate: false)
  final String productId;
  final int price;
  final String currency;
  final String image;
  final String title;
  final String description;
  final int amount;


  const ProductData({
    required this.productId,
    required this.price,
    required this.currency,
    required this.image,
    required this.title,
    required this.description,
    required this.amount
  });

  factory ProductData.empty({productId = '', price = 0, currency = '', image = '', title = '', description = '', amount = 0}) {
    return ProductData(productId: productId, price: price, currency: currency, image: image, title: title, description: description, amount: amount);
  }
}

