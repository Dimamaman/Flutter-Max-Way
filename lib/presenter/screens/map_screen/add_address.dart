
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/model/LocationModel.dart';
import '../../pref/location_pref.dart';
import '../../utils/map_utils.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  final _addressController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _entranceController = TextEditingController();
  final _floorController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final mapController = Completer<YandexMapController>();
  LocationModel _locationModel = LocationModel();
  var locationName = '';
  final pref = LocationPref();

  @override
  void setState(VoidCallback fn) {
    getCurrentPosition((locationModel) {
      setState(() {
        _locationModel = locationModel;
      });
    });
    super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(children: [
                  YandexMap(
                    onMapCreated: (controller) {
                      move();
                      mapController.complete(controller);
                    },
                    onCameraPositionChanged: (position,_,finished) {
                      if(finished) {
                        getCameraPosition();
                      }
                    },
                  ),
                  Center(
                      child: Image.asset(
                        'assets/images/marker.png',
                        width: 40,
                        height: 50,
                      )),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white.withOpacity(0.7)),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        move();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.location_on_outlined),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                      ),
                    ),
                  )
                ]),
              ),
              Expanded(flex: 1, child: Container())
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(child: SizedBox()),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.25 + 20,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Адрес доставки',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/send.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  locationName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 15,
                                    fontFamily: 'SF Pro Text',
                                    fontWeight: FontWeight.w400,
                                    height: 1.33,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          pref.setPosition(locationName);
                          pref.setIsFirst(false);
                          Navigator.pop(context);
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) {
                          //       return MainScreen();
                          //     }));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF51267D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Confirm',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w600,
                                height: 1.47,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],)
      ),
    );
  }

  Future<void> move() async {
    var controller = await mapController.future;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      controller.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: Point(
                latitude: position.latitude, longitude: position.longitude))),
        animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      );
    }).catchError((e) {

    });

    getCameraPosition();
  }

  Future<void> getCameraPosition() async {
    (await mapController.future).getCameraPosition().then((value) {
      getPlaceMark(value.target.latitude,value.target.longitude);
    });
  }

  Future<void> getPlaceMark(double lat, double lon) async {
    getAddressFromLatLong(lat, lon, (locationModel) {
      _locationModel = locationModel;
      setState(() {});
    });
  }



}


AppBar _buildAppBar() {
  return AppBar(

    title: const Text(
      'Адрес доставки',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontFamily: 'SF Pro Display',
        fontWeight: FontWeight.w600,
        height: 1.29,
      ),
    ),
    centerTitle: true,
  );
}