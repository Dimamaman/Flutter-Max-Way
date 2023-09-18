import 'package:floor/floor.dart';

@entity
class OrderEntity {
  @PrimaryKey(autoGenerate: false)
  int orderNo;
  String branch;
  String time;
  String date;
  String payment;
  String products;
  int price;
  String address;
  String? delivery;
  String? scheduledTime;
  bool isCompleted;

  OrderEntity({
    required this.orderNo,
    required this.branch,
    required this.time,
    required this.date,
    required this.payment,
    required this.products,
    required this.price,
    required this.address,
    this.isCompleted = false
  });

  factory OrderEntity.empty({
    int orderNo = 0,
    String time = '',
    String date = '',
    String payment = '',
    String products = '',
    String address = '',
    int price = 0,
    bool isCompleted = false
  }) => OrderEntity(orderNo: orderNo, branch: '', time: time, date: date, payment: payment, products: products, price: price, address: address, isCompleted: isCompleted);
}