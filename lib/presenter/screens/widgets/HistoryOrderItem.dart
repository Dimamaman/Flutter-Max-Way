
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/floor/entity/order_entity.dart';
import '../my_orders/pages/history/history_detail/history_order_page.dart';

class HistoryOrderItem extends StatelessWidget {
  const HistoryOrderItem({
    super.key,
    required this.orderEntity,
  });

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => HistoryOrderPage(orderEntity: orderEntity)));
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 90,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Buyurtma №${orderEntity.orderNo}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.lightBlue[50]),
                    child: const Text('Buyurtma tugallandi', style: TextStyle(color: Colors.blue)),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${orderEntity.price} so\'m', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Row(
                    children: [
                      Icon(Icons.date_range_rounded, size: 15, color: Colors.grey[600]),
                      const SizedBox(width: 3),
                      Text(orderEntity.date, style: TextStyle(color: Colors.grey[600], fontSize: 15))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}