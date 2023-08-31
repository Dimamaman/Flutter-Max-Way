import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/floor/dao/address_dao.dart';
import 'package:flutter_max_way/core/floor/entity/address.dart';
import 'package:flutter_max_way/presenter/screens/map_screen/add_address.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../../core/floor/database/database.dart';
import '../../../di/floor_module.dart';
import '../../utils/toast.dart';
import '../map_screen/add_address_map.dart';

class MyAddress extends StatefulWidget {
   MyAddress({super.key});

  final _addressDao = getIt<AppDatabase>().addressDao;
  List<Address> products = [];

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {

  Future<AddressDao> _callAddress() async {
    return widget._addressDao;
  }

  void _delete(Address address) {
    try {
      widget._addressDao.deleteAddress(address);
    } catch (e) {
      showToast(['$e'], context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Address",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: FutureBuilder(
                future: _callAddress(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return StreamBuilder(
                        stream: snapshot.data!.streamedData(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
                            return const Center(
                                child: CupertinoActivityIndicator(
                                  radius: 20,
                                  color: Color(0xff51267D),
                                ));
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 110, child: SvgPicture.asset('assets/images/bag.svg')),
                                      const SizedBox(height: 30),
                                      const Text('Savatda hali mahsulot yo\'q'),
                                    ],
                                  ));
                            }
                            return SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  width: double.infinity,
                                  height: snapshot.data!.length * 70 + 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) => const Divider(height: 1, indent: 20, endIndent: 20),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (_, i) {
                                      final address = snapshot.data![i];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.place_outlined,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(address.addressName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                  Text(address.locationName,
                                                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                                  const SizedBox(height: 15),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {

                                                  _delete(address);
                                                },
                                                icon: Icon(Icons.delete_outline_outlined, color: Colors.grey[400])),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                  }
                },
              )
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff51267D),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => const AddAddressMapPage()));
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Text(" + Add Address",style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
