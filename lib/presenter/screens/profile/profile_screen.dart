import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/about_the_service/about_the_service.dart';
import 'package:flutter_max_way/presenter/screens/auth/phone.dart';
import 'package:flutter_max_way/presenter/screens/branches/branches.dart';
import 'package:flutter_max_way/presenter/screens/edit_profile/edit_profile.dart';
import 'package:flutter_max_way/presenter/screens/home/home_page.dart';
import 'package:flutter_max_way/presenter/screens/my_address/my_address.dart';
import 'package:flutter_max_way/presenter/screens/settings/settings.dart';

import '../../pref/location_pref.dart';
import '../main_page.dart';

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

  _readName() async {
    return await pref.getName();
  }

  _readPhone() async {
    return await pref.getPhone();
  }

  @override
  void initState() {
    setState(() {});
    next();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      name = await _readName();
      phone = await _readPhone();
    });

    print("NAME D -> $name}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      name = await _readName();
      phone = await _readPhone();
    });
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,overflow: TextOverflow.ellipsis),
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
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (_) => EditProfile()));
                      },
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
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (_) =>  MyAddress()));
                    },
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
                      Navigator.push(context, CupertinoPageRoute(builder: (_) => const SettingsScreen()));
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
            context, MaterialPageRoute(builder: (_) => const MainScreen()));
        print("WWWWWWWWWWW onWillPop");
        return true;
      },
    );
  }
}
