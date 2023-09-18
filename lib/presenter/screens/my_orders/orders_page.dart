import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/my_orders/pages/current/current_tab.dart';
import 'package:flutter_max_way/presenter/screens/my_orders/pages/history/history_tab.dart';


class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin{
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
          title: const Text(
            'Buyurtmalarim',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10)),
              child: TabBar(
                padding: const EdgeInsets.all(4),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                controller: tabController,
                tabs: const [
                  Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("Amaldagi buyurtmalar")
                      )
                  ),
                  Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("Buyurtmalar tarixi")
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
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
