
import 'package:flutter/material.dart';

class Tab1 extends StatelessWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(width: 150,height: 180,'assets/images/order_unaviable2.png'),
          const Text("Order unavailable",style: TextStyle(color: Colors.grey),),
          const SizedBox(height: 50,)
        ],
      )),
    );
  }
}
