import 'package:floor/floor.dart';

@entity
class OrderEntity {
  @PrimaryKey(autoGenerate: false)
  String orderNo;
  String branch;
  String time;
  String date;
  String payment;
  String products;
  int price;

  OrderEntity({
    required this.orderNo,
    required this.branch,
    required this.time,
    required this.date,
    required this.payment,
    required this.products,
    required this.price,
  });

  factory OrderEntity.empty({
    String orderNo = '',
    String branch = '',
    String time = '',
    String date = '',
    String payment = '',
    String products = '',
    int price = 0,
  }) => OrderEntity(orderNo: orderNo, branch: branch, time: time, date: date, payment: payment, products: products, price: price);
}