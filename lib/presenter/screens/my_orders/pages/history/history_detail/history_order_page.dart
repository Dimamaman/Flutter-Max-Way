
import 'package:flutter/material.dart';

import '../../../../../../core/floor/entity/order_entity.dart';
import '../../../../../utils/toast.dart';


class HistoryOrderPage extends StatefulWidget {

  final OrderEntity _orderEntity;

  const HistoryOrderPage({super.key, required OrderEntity orderEntity}) : _orderEntity = orderEntity;

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  @override
  Widget build(BuildContext context) {

    List<String> products = widget._orderEntity.products.split("#");

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Order № ${widget._orderEntity.orderNo}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),

          Material(
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order № ${widget._orderEntity.orderNo}',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[50]
                        ),
                        child: const Text('Order completed', style: TextStyle(color: Colors.blue, fontSize: 13)),
                      )
                    ],
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,color: Colors.grey,),
                      const SizedBox(width: 10,),
                      const Text('Address', style: TextStyle(fontSize: 14,color: Colors.grey)),
                      const Spacer(),
                      SizedBox(width: 270, child: Text(widget._orderEntity.address, maxLines: 2, textAlign: TextAlign.right, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15))),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      const Icon(Icons.access_time,color: Colors.grey,),
                      const SizedBox(width: 10,),
                      const Text('Time', style: TextStyle(fontSize: 14,color: Colors.grey)),
                      const Spacer(),
                      Text(widget._orderEntity.time, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      const Icon(Icons.date_range,color: Colors.grey,),
                      const SizedBox(width: 10,),
                      const Text('Date', style: TextStyle(fontSize: 14,color: Colors.grey)),
                      const Spacer(),
                      Text(widget._orderEntity.date, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      const Icon(Icons.payment,color: Colors.grey,),
                      const SizedBox(width: 10,),
                      const Text("Payment method", style: TextStyle(fontSize: 14,color: Colors.grey)),
                      const Spacer(),
                      Text(widget._orderEntity.payment, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 20,),

          Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Check', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                SizedBox(
                    height: products.length * 30,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final data = products[index];

                        final product = data.split(",");

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product[0], style: const TextStyle(color: Colors.grey, height: 1)),
                            Text("${product[2]} x ${product[1]}", style: const TextStyle(color: Colors.grey, height: 1)),
                          ],
                        );
                      },
                    )),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    Text('${widget._orderEntity.price} so\'m', style: const TextStyle(fontSize: 17,color: Colors.grey))
                  ],
                )
              ],
            ),
          ),

          const Expanded(child: SizedBox()),

          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Material(
              clipBehavior: Clip.antiAlias,
              color: const Color(0xff51267D),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  reOrder(widget._orderEntity);
                  showToast(['Successful'], context);
                  Navigator.pop(context);
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.height*0.065,
                    child: const Center(
                        child: Text('Repeat the order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
