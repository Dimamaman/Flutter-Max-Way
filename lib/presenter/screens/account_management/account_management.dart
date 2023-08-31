import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({super.key});

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Account Management",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                width: double.infinity,
                height: 540,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,),
                      Image.asset('assets/images/image 105.png',height: 150, width: 150,),
                      const SizedBox(height: 15,),
                      const Text("We hope you are not here to delete your account.", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),textAlign: TextAlign.center,),
                      const SizedBox(height: 15,),
                      const Text("We're sorry to hear you're leaving. If you choose to continue, these are the next steps:", style: TextStyle(fontSize: 14, color: Colors.grey,),textAlign: TextAlign.center,),
                      const SizedBox(height: 15,),
                      const Text("- Upon your confirmation, your registered addresses and payment information will be deleted.", style: TextStyle(fontSize: 14, color: Colors.grey),textAlign: TextAlign.center,),
                      const SizedBox(height: 15,),
                      const Text("- If you choose to delete your MaxWay account, Your account registration data, your past orders, and your favourites are deleted.", style: TextStyle(fontSize: 14, color: Colors.grey),textAlign: TextAlign.center,),
                      const SizedBox(height: 15,),
                      const Text("- Please remember that if you choose to delete your MaxWay account, you will not be able to use other services in MaxWay through the application.", style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: InkWell(
                  onTap: () async {
                    // Navigator.push(context, CupertinoPageRoute(builder: (_) => const AboutUs()));
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => const MainScreen()));
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      width: double.infinity,
                      child: const Center(child: Text("Delete your account", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)))),
                ),
              ),
            ),

            const SizedBox(height: 15,)
          ],
        ));
  }
}
