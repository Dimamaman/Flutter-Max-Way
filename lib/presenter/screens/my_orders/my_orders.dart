
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/my_orders/pages/tab1.dart';
import 'package:flutter_max_way/presenter/screens/my_orders/pages/tab2.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Orders',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10)),
              child: TabBar(
                padding: const EdgeInsets.only(top: 3,bottom: 3),
                labelStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                controller: tabController,
                tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Current orders")
                    )
                  ),
                  Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("History of orders")
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  Tab1(),
                  Tab2()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
