import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/core/floor/database/database.dart';
import 'package:flutter_max_way/presenter/screens/auth/phone.dart';
import 'package:flutter_max_way/presenter/screens/cart/cart_page_samandar.dart';
import 'package:flutter_max_way/presenter/screens/cart/cart_screen.dart';
import 'package:flutter_max_way/presenter/screens/home/home_page.dart';
import 'package:flutter_max_way/presenter/screens/profile/profile_screen.dart';
import 'package:flutter_max_way/presenter/utils/navigator.dart';
import 'package:provider/provider.dart';

import '../../di/floor_module.dart';
import '../pref/location_pref.dart';
import '../utils/badges.dart';

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
  int badges = 0;

  @override
  void initState() {
    next();
    _currentIndex = widget.position;
    super.initState();
  }

  Future<void> next() async {
    isLogged = await pref.getIsLogged();
    var temp = await getIt<AppDatabase>().productDao.getAllProducts();
    badges = temp.length;
    setState(() {});
    print("PPPPPPPPPPPPP ${badges}");
    // await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BadgeProvider>(
      builder: (context, value, child) => Scaffold(
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
          items:  [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('${context.watch<BadgeProvider>().badgeValue}'),
                child: const Icon(Icons.shopping_cart),
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'My orders',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
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
