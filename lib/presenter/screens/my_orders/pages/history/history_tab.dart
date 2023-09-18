import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/floor/dao/order_dao.dart';
import '../../../../../core/floor/database/database.dart';
import '../../../../../di/floor_module.dart';
import '../../../widgets/HistoryOrderItem.dart';

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  final _dao = getIt<AppDatabase>().orderDao;

  Future<OrderDao> _callDao() async {
    return _dao;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _callDao(),
      builder: (context, snapshot) {
        return StreamBuilder(
          stream: snapshot.data?.streamedDataHistory(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
              return Container(
                color: const Color(0xFFF6F6F6),
                child: const Center(child: CupertinoActivityIndicator()),
              );
            } else {
              if (snapshot.data!.isEmpty) {
                return Container(
                  color: const Color(0xFFF6F6F6),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(height: 120, 'assets/images/place_holder.png'),
                      const SizedBox(height: 20),
                      const Text(
                        "Order not available",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  )),
                );
              }
              return Scaffold(
                backgroundColor: const Color(0xFFF6F6F6),
                body: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return HistoryOrderItem(orderEntity: snapshot.data![index]);
                  },
                ),
              );
            }
          }
        );
      },
    );
  }
}