import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/branch_model.dart';


class BranchPage extends StatefulWidget {
  const BranchPage({super.key, required this.branch});

  final Branch branch;

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri phoneUri = Uri(
        scheme: "tel",
        path: contactNumber
    );
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (error) {
      throw("Cannot dial $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          'Filiallar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Center(
                  child: Image.asset(
                    'assets/images/maxway_purple.png',
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  widget.branch.name,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.placemark,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      'Manzil',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    )),
                    Expanded(
                      child: Text(
                        widget.branch.address,
                        maxLines: 2,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, indent: 15, endIndent: 15,),
              InkWell(
                onTap: () {
                  MapsLauncher.launchCoordinates(widget.branch.location.lat, widget.branch.location.long);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.placemark,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        'Ma\'lumot nuqtasi',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      )),
                      Expanded(
                        child: Text(
                          widget.branch.destination,
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, indent: 15, endIndent: 15,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      'Ish vaqti',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    )),
                    Expanded(
                      child: Text(
                        '${widget.branch.workHourStart} - ${widget.branch.workHourEnd}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, indent: 15, endIndent: 15,),
              InkWell(
                onTap: () {
                  launchPhoneDialer(widget.branch.phone);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.phone,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        'Telefon raqam',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      )),
                      Expanded(
                        child: Text(
                          widget.branch.phone,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
