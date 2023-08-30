import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/map_screen/add_address.dart';
import 'package:hive/hive.dart';

import '../map_screen/add_address_map.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Address",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(width: 150,height: 180,'assets/images/order_unaviable2.png'),
          const Text("Order unavailable",style: TextStyle(color: Colors.grey),),


          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff51267D),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => const AddAddressMapPage()));
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Text(" + Add Address",style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
