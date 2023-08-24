import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    next().then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MainScreen()))
    );
    super.initState();
  }

  Future<void> next() async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF51267D),
      body: Center(
        child: SizedBox(
            height: 200, child: Image.asset('assets/images/image 105.png')),
      ),
    );
  }
}
