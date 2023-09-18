import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/floor/dao/order_dao.dart';
import '../../../../../core/floor/database/database.dart';
import '../../../../../di/floor_module.dart';
import '../../../widgets/CurrentOrderItem.dart';


class Tab1 extends StatefulWidget {
  Tab1({Key? key}) : super(key: key);

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  final _dao = getIt<AppDatabase>().orderDao;

  Future<OrderDao> _callDao() async {
    return _dao;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _callDao(),
      builder: (context,snapshot) {
        return StreamBuilder(
          stream: snapshot.data?.streamedDataCurrent(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
              return Container(
                color: const Color(0xFFF6F6F6),
                child: const Center(
                    child: CupertinoActivityIndicator()
                ),
              );
            } else {
              if (snapshot.data!.isEmpty) {
                return Container(
                  color: const Color(0xFFF6F6F6),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(height: 120,'assets/images/place_holder.png'),
                      const SizedBox(height: 20),
                      const Text("Order not available",style: TextStyle(color: Colors.grey),),
                      const SizedBox(height: 50,)
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
                    bool isReady = false;
                    final format = '${snapshot.data![index].date.substring(6,10)}-'
                        '${snapshot.data![index].date.substring(3,5)}-${snapshot.data![index].date.substring(0,2)} '
                        '${snapshot.data![index].time}:00';
                    if(DateTime.now().difference(DateTime.parse(format)).inMinutes > 4){
                      isReady = true;
                    }
                    return CurrentOrderItem(isReady: isReady, orderEntity: snapshot.data![index]);
                  },
                ),
              );
            }
          }
        );
      }
    );
  }
}
