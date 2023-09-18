import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/floor/entity/order_entity.dart';
import '../my_orders/pages/current/current_detail/current_order_page.dart';


class CurrentOrderItem extends StatelessWidget {
  const CurrentOrderItem({
    super.key,
    required this.isReady,
    required this.orderEntity,
  });

  final bool isReady;
  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => CurrentOrderPage(orderEntity: orderEntity, isReady: isReady)));
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 140,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Buyurtma №${orderEntity.orderNo}',
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue[50]
                    ),
                    child: Text(isReady?'Buyurtma tayyor':'Buyurtma rasmiylashtirildi', style: const TextStyle(color: Colors.blue, fontSize: 13)),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: const Color(0xff51267D),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: const Center(child: Icon(Icons.check_rounded, color: Colors.white)),
                  ),
                  const Expanded(child: Divider(thickness: 2, color: Color(0xff51267D),)),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: const Color(0xff51267D),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Image.asset('assets/images/chef_hat.png', color: Colors.white),
                    )),
                  ),
                  Expanded(child: Divider(thickness: 2, color: isReady ? const Color(0xff51267D) : const Color(0xFFF6F6F6))),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: isReady ? const Color(0xff51267D) : const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Image.asset('assets/images/flag.png', color: isReady ? Colors.white : const Color(0xff51267D)),
                    )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}