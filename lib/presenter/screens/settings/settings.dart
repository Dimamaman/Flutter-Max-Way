import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/my_bottomsheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool light = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showMyBottomSheet();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.language_rounded,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          'Language',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        Icon(
                          Icons.navigate_next,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.notifications,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                          child: Text(
                        'Notifications',
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                      CupertinoSwitch(
                        value: light,
                        onChanged: onChangedFunction,
                        dragStartBehavior: DragStartBehavior.start,
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  // Navigator.push(context, CupertinoPageRoute(builder: (_) => const AboutUs()));
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    width: double.infinity,
                    child: const Center(child: Text("Log Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)))),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  showMyBottomSheet() {
    showModalBottomSheet(context: context, builder: (_) {
      return StatefulBuilder(
        builder: (context,StateSetter setBottomState) =>
            const CustomBottomSheet()
      );
    });
  }

  onChangedFunction(bool newValue) {
    setState(() {
      light = newValue;
    });
  }
}
