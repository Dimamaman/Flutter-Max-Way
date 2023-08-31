import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/floor/entity/address.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/floor/database/database.dart';
import '../../../core/model/LocationModel.dart';
import '../../../di/floor_module.dart';
import '../../utils/map_utils.dart';


class AddAddressMapPage extends StatefulWidget {
  const AddAddressMapPage({Key? key}) : super(key: key);

  @override
  State<AddAddressMapPage> createState() => _AddAddressMapPageState();
}

class _AddAddressMapPageState extends State<AddAddressMapPage> {
  final mapController = Completer<YandexMapController>();
  var _locationModel = LocationModel();
  var locationName = '';
  final _addressDao = getIt<AppDatabase>().addressDao;

  final nameController = TextEditingController();
  final flatController = TextEditingController();
  final floorController = TextEditingController();
  final entranceController = TextEditingController();

  final nameNode = FocusNode();
  final apartmentNode = FocusNode();
  final entranceNode = FocusNode();
  final floorNode = FocusNode();

  var name = '';
  var flat = '';
  var entrance = '';
  var floor = '';

  late Point point;
  bool _validate = false;

  @override
  void initState() {
    handleLocationPermission();

    nameController.addListener(() {
      name = nameController.text;
    });
    flatController.addListener(() {
      flat = flatController.text;
    });
    entranceController.addListener(() {
      entrance = entranceController.text;
    });
    floorController.addListener(() {
      floor = floorController.text;
    });

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    flatController.dispose();
    entranceController.dispose();
    floorController.dispose();
    super.dispose();
  }

  Future<void> getCameraPos() async {
    (await mapController.future).getCameraPosition().then((value) {
      getPlaceMark(value.target.latitude, value.target.longitude);
    });
  }

  Future<void> move() async {
    var controller = await mapController.future;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
          point = Point(latitude: position.latitude, longitude: position.longitude);
      controller.moveCamera(
          animation:
          const MapAnimation(type: MapAnimationType.linear, duration: 1),
          CameraUpdate.newCameraPosition(CameraPosition(
              target: Point(
                  latitude: position.latitude,
                  longitude: position.longitude))));
    }).catchError((e) {
      //
    });
    getCameraPos();
  }

  Future<void> getPlaceMark(double lat, double long) async {
    getAddressFromLatLong(lat, long, (locationModel) {
      _locationModel = locationModel;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    locationName = _locationModel.street.isEmpty ? '' : '${_locationModel.street}, ${_locationModel.regionName}, ${_locationModel.cityName}';
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              child: Stack(children: [
                YandexMap(
                  onCameraPositionChanged: (cameraPosition, reason, finished) {
                    if (finished) {
                      getCameraPos();
                    }
                  },
                  onMapCreated: (controller) {
                    mapController.complete(controller);
                    move();
                  },
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Image.asset('assets/images/marker.png',
                          height: 50)),
                ),
                Positioned(
                  bottom: 40,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      move();
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.navigation,
                          color: Color(0xff51267D),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              height: 325,
            )
          ],
        ),
        Column(
          children: [
            Expanded(child: Container()),
            Material(
              elevation: 10,
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: SizedBox(
                height: 345,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery address',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            locationName,
                            style: const TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(child: Container(
                                padding: const EdgeInsets.only(left: 12,bottom: 3, top: 3),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                                child: TextField(
                                  controller: flatController,
                                  focusNode: apartmentNode,
                                  onTapOutside: (event) {
                                    apartmentNode.unfocus();
                                    setState(() {});
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Entrance',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: flatController.text.isNotEmpty
                                        ? InkWell(
                                        onTap: () => flatController.text = '',
                                        child: const Icon(Icons.close,
                                            color: Color(0xFFAFAFAF)))
                                        : null,
                                  ),
                                ),
                              ),),
                              const SizedBox(width: 12,),
                              Expanded(child: Container(
                                padding: const EdgeInsets.only(left: 12,bottom: 3, top: 3),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                                child: TextField(
                                  controller: entranceController,
                                  focusNode: entranceNode,
                                  onTapOutside: (event) {
                                    entranceNode.unfocus();
                                    setState(() {});
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Floor',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: entranceController.text.isNotEmpty
                                        ? IconButton(
                                        onPressed: () {
                                          entranceController.clear();
                                          entranceNode.unfocus();
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                        ))
                                        : null,
                                  ),
                                ),
                              ),),
                              const SizedBox(width: 12,),
                              Expanded(child: Container(
                                padding: const EdgeInsets.only(left: 12,bottom: 3, top: 3),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                                child: TextField(
                                  controller: floorController,
                                  focusNode: floorNode,
                                  onTapOutside: (event) {
                                    floorNode.unfocus();
                                    setState(() {});
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Flat',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: floorController.text.isNotEmpty
                                        ? InkWell(
                                        onTap: () => floorController.text = '',
                                        child: const Icon(Icons.close,
                                            color: Color(0xFFAFAFAF)))
                                        : null,
                                  ),
                                ),
                              ),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 12,bottom: 4, top: 4),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Address name',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                suffixIcon: nameController.text.isNotEmpty
                                    ? InkWell(
                                    onTap: () => nameController.text = '',
                                    child: const Icon(Icons.close, color: Color(0xFFAFAFAF)))
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Material(
                          clipBehavior: Clip.antiAlias,
                          color: const Color(0xff51267D),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              // prefs.setLocation(locationName.replaceAll('Uzbekistan', 'O\'zbekiston'));
                              if(nameController.text.isEmpty) {
                                _validate = true;
                                setState(() {});
                              } else {

                                _addressDao.insertAddress(
                                  Address(lat: _locationModel.lat,long: _locationModel.long,locationName: locationName, entrance: entrance, floor: floor, flat: flat, addressName: name)
                                );

                                Navigator.pop(context);
                                _validate = false;
                                setState(() {});
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              child: const Text(
                                'Confirm',
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
