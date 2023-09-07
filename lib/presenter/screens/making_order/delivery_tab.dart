import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/making_order/map/pick_address_map_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/floor/database/database.dart';
import '../../../core/floor/entity/product_data.dart';
import '../../../core/model/LocationModel.dart';
import '../../../di/floor_module.dart';
import '../../utils/map_utils.dart';

class OrderDeliveryTab extends StatefulWidget {
  const OrderDeliveryTab({super.key, required this.list, required this.totalPrice});

  final int totalPrice;
  final List<ProductData> list;

  @override
  State<OrderDeliveryTab> createState() => _OrderDeliveryTabState();
}

enum ShouldCourierCall { yes, no }

enum PaymentMethod { click, payme, cash }

enum DeliveryType { fast, scheduled }

class _OrderDeliveryTabState extends State<OrderDeliveryTab> {
  final mapController = Completer<YandexMapController>();
  var _locationModel = LocationModel();
  final _orderDao = getIt<AppDatabase>().orderDao;
  var locationName = '';

  final nameController = TextEditingController();
  final apartmentController = TextEditingController();
  final floorController = TextEditingController();
  final entranceController = TextEditingController();
  final addressController = TextEditingController();
  final nameNode = FocusNode();
  final apartmentNode = FocusNode();
  final entranceNode = FocusNode();
  final floorNode = FocusNode();

  var name = '';
  var apartment = '';
  var entrance = '';
  var floor = '';

  @override
  void initState() {
    addressController.text = 'Manzil tanlang';
    nameController.addListener(() {
      name = nameController.text;
    });
    apartmentController.addListener(() {
      apartment = apartmentController.text;
    });
    entranceController.addListener(() {
      entrance = entranceController.text;
    });
    floorController.addListener(() {
      floor = floorController.text;
    });
    setState(() {});
    super.initState();
  }

  Future<void> _getLocationFromMap() async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => const PickAddressMapPage()));
    _locationModel = result;
    moveToPoint(Point(latitude: _locationModel.lat, longitude: _locationModel.long));
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    apartmentController.dispose();
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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((Position position) {
      controller.moveCamera(
          animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
          CameraUpdate.newCameraPosition(CameraPosition(target: Point(latitude: position.latitude, longitude: position.longitude))));
    }).catchError((e) {
      //
    });
    getCameraPos();
  }

  Future<void> moveToPoint(Point point) async {
    var controller = await mapController.future;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((Position position) {
      controller.moveCamera(
          animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
          CameraUpdate.newCameraPosition(CameraPosition(target: Point(latitude: point.latitude, longitude: point.longitude))));
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

  ShouldCourierCall? action = ShouldCourierCall.yes;

  void _courierCallOption(ShouldCourierCall? value) {
    action = value;
    setState(() {});
  }

  DeliveryType? type = DeliveryType.fast;

  void _deliveryOption(DeliveryType? value) {
    type = value;
    setState(() {});
  }

  PaymentMethod? method = PaymentMethod.cash;

  void _paymentOption(PaymentMethod? value) {
    method = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    locationName = _locationModel.cityName.isEmpty ? '' : '${_locationModel.regionName}, ${_locationModel.cityName},${_locationModel.street}';
    return Container(
      color: const Color(0xFFF5F5F5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 10),
                  const Text('Current address'),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      locationName.replaceAll('Uzbekistan', 'O\'zbekiston').replaceAll(', Unnamed Road', ''),
                      maxLines: 2,
                      style: const TextStyle(height: 1.1, fontSize: 16, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, bottom: 3, top: 3),
                            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: const BorderRadius.all(Radius.circular(10))),
                            child: TextField(
                              controller: entranceController,
                              focusNode: entranceNode,
                              onTapOutside: (event) {
                                entranceNode.unfocus();
                                setState(() {});
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Pod`ezd',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
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
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, bottom: 3, top: 3),
                            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: const BorderRadius.all(Radius.circular(10))),
                            child: TextField(
                              controller: floorController,
                              focusNode: floorNode,
                              onTapOutside: (event) {
                                floorNode.unfocus();
                                setState(() {});
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Floor',
                                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                suffixIcon: floorController.text.isNotEmpty
                                    ? InkWell(onTap: () => floorController.text = '', child: const Icon(Icons.close, color: Color(0xFFAFAFAF)))
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, bottom: 3, top: 3),
                            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: const BorderRadius.all(Radius.circular(10))),
                            child: TextField(
                              controller: apartmentController,
                              focusNode: apartmentNode,
                              onTapOutside: (event) {
                                apartmentNode.unfocus();
                                setState(() {});
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Apartment',
                                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                suffixIcon: apartmentController.text.isNotEmpty
                                    ? InkWell(onTap: () => apartmentController.text = '', child: const Icon(Icons.close, color: Color(0xFFAFAFAF)))
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: YandexMap(
                            logoAlignment: const MapAlignment(horizontal: HorizontalAlignment.center, vertical: VerticalAlignment.top),
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
                        ),
                        Center(
                          child: Padding(padding: const EdgeInsets.only(bottom: 30), child: SvgPicture.asset('assets/images/pin.svg',
                              height: 50)),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Material(
                            elevation: 5,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                move();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset('assets/images/navigate.svg'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Material(
                            elevation: 5,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                _getLocationFromMap();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Transform.rotate(
                                    angle: 1.5,
                                    child: const Icon(
                                      CupertinoIcons.arrow_up_left_arrow_down_right,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('My addresses'),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 12),
                    decoration:
                        BoxDecoration(color: Colors.grey[100], borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: const Color(0xff51267D))),
                    child: TextField(
                      enableInteractiveSelection: false,
                      enableSuggestions: false,
                      controller: addressController,
                      readOnly: true,
                      textInputAction: TextInputAction.done,
                      onTap: () {
                        ///
                      },
                      style: TextStyle(color: Colors.grey[700]),
                      decoration: const InputDecoration(border: InputBorder.none, suffixIcon: Icon(Icons.keyboard_arrow_down_outlined)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text('Do you want the courier to call you?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _courierCallOption(ShouldCourierCall.yes),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            CupertinoRadio<ShouldCourierCall>(
                              value: ShouldCourierCall.yes,
                              groupValue: action,
                              onChanged: (ShouldCourierCall? value) {},
                              activeColor: Colors.deepPurple,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('Yes'))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[300], height: 1, indent: 15, endIndent: 15),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _courierCallOption(ShouldCourierCall.no),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            CupertinoRadio<ShouldCourierCall>(
                              value: ShouldCourierCall.no,
                              groupValue: action,
                              onChanged: (ShouldCourierCall? value) {},
                              activeColor: Colors.deepPurple,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('No'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text('Delivery method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _deliveryOption(DeliveryType.fast),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            SvgPicture.asset('assets/images/take_away.svg'),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('Fast delivery')),
                            CupertinoRadio<DeliveryType>(
                              value: DeliveryType.fast,
                              groupValue: type,
                              onChanged: (DeliveryType? value) {},
                              activeColor: Colors.deepPurple,
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[300], height: 1, indent: 65),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _deliveryOption(DeliveryType.scheduled),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            SvgPicture.asset('assets/images/courier.svg'),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('Delivery on schedule')),
                            CupertinoRadio<DeliveryType>(
                              value: DeliveryType.scheduled,
                              groupValue: type,
                              onChanged: (DeliveryType? value) {},
                              activeColor: Colors.deepPurple,
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text('Payment type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _paymentOption(PaymentMethod.cash),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            SvgPicture.asset('assets/images/cash.svg'),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('Cash')),
                            CupertinoRadio<PaymentMethod>(
                              value: PaymentMethod.cash,
                              groupValue: method,
                              onChanged: (PaymentMethod? value) {},
                              activeColor: Colors.deepPurple,
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[300], height: 1, indent: 65),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _paymentOption(PaymentMethod.payme),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            SvgPicture.asset('assets/images/payme.svg'),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('Payme')),
                            CupertinoRadio<PaymentMethod>(
                              value: PaymentMethod.payme,
                              groupValue: method,
                              onChanged: (PaymentMethod? value) {},
                              activeColor: Colors.deepPurple,
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[300], height: 1, indent: 65),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _paymentOption(PaymentMethod.click),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            SvgPicture.asset('assets/images/click.svg'),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('Click')),
                            CupertinoRadio<PaymentMethod>(
                              value: PaymentMethod.click,
                              groupValue: method,
                              onChanged: (PaymentMethod? value) {},
                              activeColor: Colors.deepPurple,
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Check', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  SizedBox(
                      height: widget.list.length * 30,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(height: 14, color: Colors.grey[300]),
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) {
                          final data = widget.list[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data.title, style: const TextStyle(color: Colors.grey, height: 1)),
                              Text(
                                '${data.amount} x ${data.price} so\'m',
                                style: const TextStyle(color: Colors.grey, height: 1),
                              )
                            ],
                          );
                        },
                      )),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Shipping cost", style: TextStyle(color: Colors.grey)), Text('10 000 so\'m', style: TextStyle(color: Colors.grey))],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total cost', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      Text('${widget.totalPrice + 10000} so\'m', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
