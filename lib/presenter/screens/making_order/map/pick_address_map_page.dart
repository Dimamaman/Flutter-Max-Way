import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../core/model/LocationModel.dart';
import '../../../pref/location_pref.dart';
import '../../../utils/map_utils.dart';

class PickAddressMapPage extends StatefulWidget {
  const PickAddressMapPage({super.key});

  @override
  State<PickAddressMapPage> createState() => _PickAddressMapPageState();
}

class _PickAddressMapPageState extends State<PickAddressMapPage> {
  final mapController = Completer<YandexMapController>();
  var _locationModel = LocationModel();
  var locationName = '';
  final prefs = LocationPref();

  @override
  void initState() {
    handleLocationPermission();
    prefs.setIsFirst(false);
    super.initState();
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
    locationName = _locationModel.regionName.isEmpty ? '': '${_locationModel.cityName}, ${_locationModel.street}';
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
                      child: SvgPicture.asset('assets/images/pin.svg',
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
                        child: SvgPicture.asset('assets/images/navigate.svg'),
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
            Container(height: MediaQuery.of(context).size.height * 0.085)
          ],
        ),
        Column(
          children: [
            Expanded(child: Container()),
            Material(
              elevation: 10,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 18, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: SizedBox()),
                        Material(
                          clipBehavior: Clip.antiAlias,
                          color: const Color(0xff51267D),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(context, CupertinoPageRoute(
                              //   builder: (context) {
                              //     return ConfirmPage(
                              //       pinnedLocation: locationName,
                              //     );
                              //   },
                              // ));

                              // prefs.setLocation(locationName.replaceAll('Uzbekistan', 'O\'zbekiston'));
                              Navigator.pop(context, _locationModel);
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
