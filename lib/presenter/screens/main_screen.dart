import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/auth/phone.dart';
import 'package:flutter_max_way/presenter/screens/cart/cart_page_samandar.dart';
import 'package:flutter_max_way/presenter/screens/cart/cart_screen.dart';
import 'package:flutter_max_way/presenter/screens/home/home_page.dart';
import 'package:flutter_max_way/presenter/screens/profile/profile_screen.dart';

import '../pref/location_pref.dart';

class MainScreen extends StatefulWidget {
  final int position;
  const MainScreen({super.key,this.position = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pref = LocationPref();
  bool isLogged = false;

  int _currentIndex = 0; // Index of the currently selected tab

  @override
  void initState() {
    next();
    _currentIndex = widget.position;
    super.initState();
  }

  Future<void> next() async {
    isLogged = await pref.getIsLogged();
    // await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: IndexedStack(
        index: _currentIndex,
        children: [Home_Page(a: false),
          CartPage(),
          const OrdersScreen(),
          const ProfileScreen()
        ],
      ),
      //body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('20'),
              child: Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'My orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Orders Screen'));
  }
}
