import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/pref/location_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/floor/database/database.dart';
import '../../core/floor/entity/order_entity.dart';
import '../../di/floor_module.dart';

void showToast(List<String> message, BuildContext context, {Color color = Colors.white, ToastGravity gravity = ToastGravity.BOTTOM}) {
  final FToast toast = FToast();

  toast.init(context);

  Widget toast1 = Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: message.length == 2
        ? Column(
            children: [
              const Icon(Icons.check),
              const SizedBox(
                width: 12.0,
              ),
              Text(message[0]),
              Text(message[1]),
            ],
          )
        : Center(child: Text(message[0])),
  );

  toast.showToast(child: toast1, gravity: gravity, toastDuration: const Duration(seconds: 2));
}


void updateOrders() async {
  final dao = getIt<AppDatabase>().orderDao;
  final list = await dao.getAllCurrentOrders();
  for (var e in list) {
    final format = '${e.date.substring(6, 10)}-'
        '${e.date.substring(3, 5)}-${e.date.substring(0, 2)} '
        '${e.time}:00';
    if (DateTime.now().difference(DateTime.parse(format)).inMinutes > 20) {
      dao.updateOrder(OrderEntity(
        orderNo: e.orderNo,
        branch: e.branch,
        time: e.time,
        date: e.date,
        payment: e.payment,
        products: e.products,
        price: e.price,
        address: e.address,
        isCompleted: true,
      ));
    }
  }
}

void reOrder(OrderEntity order) async {
  final dao = getIt<AppDatabase>().orderDao;
  final pref = LocationPref();
  final orderNo = await pref.getOrderNumber();

  final newOrder = OrderEntity(
      orderNo: orderNo,
      branch: order.branch,
      time: '${DateTime.now().hour<10?'0${DateTime.now().hour}':'${DateTime.now().hour}'}:${DateTime.now().minute<10?'0${DateTime.now().minute}':'${DateTime.now().minute}'}',
      date: '${DateTime.now().day<10?'0${DateTime.now().day}':'${DateTime.now().day}'}.${DateTime.now().month<10?'0${DateTime.now().month}':'${DateTime.now().month}'}.${DateTime.now().year}',
      payment: order.payment,
      products: order.products,
      price: order.price,
      address: order.address
  );
  dao.insertOrder(newOrder);
  pref.setOrderNumber(orderNo+1);
}