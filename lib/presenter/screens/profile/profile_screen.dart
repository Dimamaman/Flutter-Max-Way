import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/about_the_service/about_the_service.dart';
import 'package:flutter_max_way/presenter/screens/auth/phone.dart';
import 'package:flutter_max_way/presenter/screens/branches/branches.dart';
import 'package:flutter_max_way/presenter/screens/home/home_page.dart';
import 'package:flutter_max_way/presenter/screens/settings/settings.dart';

import '../../pref/location_pref.dart';
import '../main_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final pref = LocationPref();
  bool isLogged = false;
  String name = '';
  String phone = '';

  Future<void> next() async {
    isLogged = await pref.getIsLogged();
    name = await pref.getName();
    phone = await pref.getPhone();
    setState(() {});
  }

  @override
  void initState() {
    next();
    // next().then((value) =>
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (_) => isLogged == true ? const ProfileScreen() : const MyPhone()))
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*next().then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => isLogged == true ? const ProfileScreen() : const MyPhone()))
    );*/
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        phone,
                        style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_rounded,
                        size: 20,
                        color: Colors.grey[600],
                      ))
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.place_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                                'My Address',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),

                  const Divider(height: 1, indent: 15, endIndent: 15,),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (_) => const BranchesScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.map_pin_ellipse,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                                'Branches',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),

                  const Divider(height: 1, indent: 15, endIndent: 15,),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (_) => SettingsScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                                'Settings',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),

                  const Divider(height: 1, indent: 15, endIndent: 15,),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (_) => const AboutTheService()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                                'About the service',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Version 1.0',
                style: TextStyle(color: Colors.grey, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10,)
          ],
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MainScreen()));
        print("WWWWWWWWWWW onWillPop");
        return true;
      },
    );
  }
}
