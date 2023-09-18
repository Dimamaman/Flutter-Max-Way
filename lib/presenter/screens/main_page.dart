import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/pref/location_pref.dart';
import 'package:flutter_max_way/presenter/screens/auth/phone.dart';
import 'package:flutter_max_way/presenter/screens/home/home_page.dart';
import 'package:flutter_max_way/presenter/screens/profile/profile_screen.dart';

import '../../core/floor/database/database.dart';
import '../../di/floor_module.dart';
import '../utils/toast.dart';
import 'cart/cart_page.dart';
import 'my_orders/orders_page.dart';


class MainScreen extends StatefulWidget {
  final int position;

  const MainScreen({super.key, this.position = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pref = LocationPref();
  bool hasLogged = false;
  bool isNotEmpty = false;
  int _selectedIndex = 0;
  var list = [];

  @override
  void initState() {
    updateOrders();
    load();
    // if (list.isNotEmpty) {
    //   isNotEmpty = true;
    // }
    _selectedIndex = widget.position;
    setState(() {});
    super.initState();
  }

  Future<void> load() async {
    hasLogged = await pref.getIsLogged();
    list = await getIt<AppDatabase>().productDao.getAllProducts();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (list.isNotEmpty) {
      setState(() {
        isNotEmpty = true;
      });
    }
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Badge(
                label: Text('${list.length}'),
                isLabelVisible: isNotEmpty,
                child: const Icon(CupertinoIcons.cart),
              ),
              label: 'Cart'),
          const BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag), label: 'Orders'),
          const BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),
        ],
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xff51267D),
        unselectedItemColor: Colors.grey[400],
        currentIndex: _selectedIndex,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Home_Page(a: false,),
          CartPage(),
          hasLogged ? const OrdersPage() : const MyPhone(),
          hasLogged ? const ProfileScreen() : const MyPhone(),
        ],
      ),
    );
  }
}
