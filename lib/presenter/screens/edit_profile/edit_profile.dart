import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_max_way/presenter/screens/account_management/account_management.dart';
import 'package:flutter_max_way/presenter/screens/main_screen.dart';
import 'package:flutter_max_way/presenter/screens/profile/profile_screen.dart';
import 'package:flutter_max_way/presenter/utils/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pref/location_pref.dart';
import '../widgets/my_bottomsheet.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  var _date = DateTime.now();

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = '';
  String phone = '';
  String date = '';
  final pref = LocationPref();
  final nameController = TextEditingController();
  final nameNode = FocusNode();
  final phoneController = TextEditingController();
  final phoneNode = FocusNode();

  final dateController = TextEditingController();
  final dateNode = FocusNode();

  Future<void> next() async {
    name = await pref.getName();
    phone = await pref.getPhone();
    date = await pref.getDate();
    setState(() {});
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'name';
    final value = prefs.getString(key);
    String? result = value;
    return result;
  }

  _readDate() async {
    return pref.getDate();
  }

  @override
  void initState() {
    next();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      nameController.text = await _read();
      dateController.text = await _readDate();
    });
    nameController.addListener(() {
      name = nameController.text;
    });

    nameController.text = name;

    phoneController.addListener(() {
      phone = phoneController.text;
    });

    dateController.text = date;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12, bottom: 4, top: 4),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: nameController,
                        focusNode: nameNode,
                        onTapOutside: (event) {
                          nameNode.unfocus();
                          setState(() {});
                        },
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Phone"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12, bottom: 4, top: 4),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        readOnly: true,
                        onTapOutside: (event) {
                          phoneNode.unfocus();
                          setState(() {});
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: phone,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Date of Birth"),
                  Container(
                    padding: const EdgeInsets.only(left: 12, bottom: 4, top: 4),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          _openBottomSheet(context);
                        },
                        controller: dateController,
                        focusNode: dateNode,
                        onTapOutside: (event) {
                          dateNode.unfocus();
                          setState(() {});
                        },
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Date of Birth',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.date_range)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (_) => const AccountManagement()));
              },
              child: const Text(
                "Account Management",
                style: TextStyle(color: Colors.indigoAccent),
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
            child: Material(
              clipBehavior: Clip.antiAlias,
              color: const Color(0xff51267D),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  // prefs.setLocation(locationName.replaceAll('Uzbekistan', 'O\'zbekiston'));
                  if(nameController.text.isEmpty) {
                    showToast(['Please fill name or date of birth'], context,gravity: ToastGravity.TOP);
                  } else {
                    pref.setName(nameController.text.toString());
                    pref.setPhone(phone);
                    pref.setDate(dateController.text.toString());
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScreen()),
                    ).then((_) => setState(() {}));
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: const Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _updateData(String newData) {
    setState(() {
      dateController.text = newData;
    });
  }

  void _openBottomSheet(BuildContext context) async {
    String newData = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return WidgetPage(updateCallback: _updateData);
      },
    );
    _updateData(newData);
    }
}

class WidgetPage extends StatefulWidget {
  @override
  _WidgetPageState createState() => _WidgetPageState();

  final void Function(String) updateCallback;

  const WidgetPage({super.key, required this.updateCallback});
}

class _WidgetPageState extends State<WidgetPage> {
  var _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
            child: Text(
              "Your date of birth",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(height: 5),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DatePickerWidget(
              looping: false,
              initialDate: DateTime.now(),
              firstDate: DateTime(1930),
              lastDate: DateTime(2023),
              dateFormat: "dd/MMMM/yyyy",
              onChange: (DateTime newDate, _) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
              pickerTheme: const DateTimePickerTheme(
                // cancel: TextButton(onPressed: _button, child: Text("Cancel")),
                itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                dividerColor: Colors.blueAccent,
              ),
            ),
          ),
          // Text("${_selectedDate ?? ''}",style: const TextStyle(color: Colors.black),),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Material(
              clipBehavior: Clip.antiAlias,
              color: const Color(0xff51267D),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  widget.updateCallback("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}");
                  Navigator.of(context).pop("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}");
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: const Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
