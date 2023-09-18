import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/presenter/screens/making_order/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/api/food_api.dart';
import '../../../core/floor/entity/product_data.dart';
import '../../../core/model/LocationModel.dart';
import '../../bloc/branches/branches_bloc.dart';
import '../../utils/map_utils.dart';
import '../widgets/branch_shimmer_order.dart';
import 'map/pick_address_map_page.dart';

class OrderTakeAwayTab extends StatefulWidget {
  const OrderTakeAwayTab({super.key, required this.list, required this.totalPrice});
  final int totalPrice;
  final List<ProductData> list;

  @override
  State<OrderTakeAwayTab> createState() => _OrderTakeAwayTabState();
}

enum PaymentMethod { click, payme, cash }
enum Branch { megaplanet, aviasozlar, risoviy, parus, magiccity, samarqanddarvoza, parkent, universam,
  royson, next, muqumiy, grandmir, sayram, maksimgorkiy, sergeli, fontan, minor }

class _OrderTakeAwayTabState extends State<OrderTakeAwayTab> {
  final mapController = Completer<YandexMapController>();
  var _locationModel = LocationModel();
  var locationName = '';
  final bloc = BranchesBloc(FoodApi());

  @override
  void initState() {
    bloc.add(LoadBranches());
    super.initState();
  }

  Future<void> getCameraPos() async {
    (await mapController.future).getCameraPosition().then((value) {
      getPlaceMark(value.target.latitude, value.target.longitude);
    });
  }

  Future<void> _getLocationFromMap() async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => const PickAddressMapPage()));
    setState(() {
      _locationModel = result;
      locationName = _locationModel.regionName.isEmpty ? '' : '${_locationModel.cityName}, ${_locationModel.street}';
      moveToPoint(Point(latitude:_locationModel.lat, longitude:_locationModel.long));
      context.read<OrderDetailProvider>().updateAddress(locationName.replaceAll('Uzbekistan', 'O\'zbekiston').replaceAll(', Unnamed Road', ''),);
    });
  }

  Future<void> moveToPoint(Point point) async {
    var controller = await mapController.future;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((Position position) {
      controller.moveCamera(
          animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
          CameraUpdate.newCameraPosition(CameraPosition(target: Point(latitude: point.latitude, longitude: point.longitude))));
    }).catchError((e) {
      //
    });
    getCameraPos();
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

  Future<void> moveToBranch(Point point) async {
    var controller = await mapController.future;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((Position position) {
      controller.moveCamera(
          animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
          CameraUpdate.newCameraPosition(CameraPosition(target: point, zoom: 18)));
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

  PaymentMethod? method = PaymentMethod.cash;
  void _paymentOption(PaymentMethod? value){
    method = value;
    setState(() {});
  }

  Branch? branch = Branch.megaplanet;
  void _branchOption(Branch value) {
    branch = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    locationName = _locationModel.regionName.isEmpty ? '' : '${_locationModel.cityName}, ${_locationModel.street}';
    return BlocBuilder<BranchesBloc, BranchesState>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          color: const Color(0xFFF5F5F5),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Eng yaqin filiallar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.22,
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
                              child: Padding(padding: const EdgeInsets.only(bottom: 30), child: SvgPicture.asset('assets/images/pin.svg', height: 50)),
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
                                        child: const Icon(CupertinoIcons.arrow_up_left_arrow_down_right,)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Builder(
                          builder: (context) {
                            if(state.status == UIStatus.loading && state.list.isEmpty){
                              return const SingleChildScrollView(child: BranchesShimmerOrder());
                            }
                            final list = state.list;
                            try{
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.megaplanet);
                                      moveToBranch(Point(latitude: list[0].location.lat, longitude: list[0].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[0].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[0].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[0].name,
                                                style: const TextStyle(
                                                  fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[0].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.megaplanet,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.aviasozlar);
                                      moveToBranch(Point(latitude: list[1].location.lat, longitude: list[1].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[1].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[1].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[1].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[1].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.aviasozlar,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.risoviy);
                                      moveToBranch(Point(latitude: list[2].location.lat, longitude: list[2].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[2].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[2].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[2].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[2].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.risoviy,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.parus);
                                      moveToBranch(Point(latitude: list[3].location.lat, longitude: list[3].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[3].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[3].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[3].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[3].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.parus,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.magiccity);
                                      moveToBranch(Point(latitude: list[4].location.lat, longitude: list[4].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[4].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[4].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[4].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[4].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.magiccity,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.samarqanddarvoza);
                                      moveToBranch(Point(latitude: list[5].location.lat, longitude: list[5].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[5].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[5].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[5].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[5].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.samarqanddarvoza,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.parkent);
                                      moveToBranch(Point(latitude: list[6].location.lat, longitude: list[6].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[6].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[6].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[6].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[6].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.parkent,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.universam);
                                      moveToBranch(Point(latitude: list[7].location.lat, longitude: list[7].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[7].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[7].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[7].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[7].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.universam,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.royson);
                                      moveToBranch(Point(latitude: list[8].location.lat, longitude: list[8].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[8].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[8].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[8].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[8].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.royson,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.next);
                                      moveToBranch(Point(latitude: list[9].location.lat, longitude: list[9].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[9].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[9].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[9].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[9].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.next,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.muqumiy);
                                      moveToBranch(Point(latitude: list[10].location.lat, longitude: list[10].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[10].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[10].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[10].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[10].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.muqumiy,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.grandmir);
                                      moveToBranch(Point(latitude: list[11].location.lat, longitude: list[11].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[11].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[11].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[11].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[11].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.grandmir,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.sayram);
                                      moveToBranch(Point(latitude: list[12].location.lat, longitude: list[12].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[12].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[12].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[12].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[12].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.sayram,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.maksimgorkiy);
                                      moveToBranch(Point(latitude: list[13].location.lat, longitude: list[13].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[13].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[13].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[13].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[13].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.maksimgorkiy,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.sergeli);
                                      moveToBranch(Point(latitude: list[14].location.lat, longitude: list[14].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[14].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[14].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[14].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[14].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.sergeli,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.fontan);
                                      moveToBranch(Point(latitude: list[15].location.lat, longitude: list[15].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[15].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[15].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[15].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[15].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.fontan,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(height: 1,indent: 50, color: Colors.grey[300],),
                                  InkWell(
                                    onTap: () {
                                      _branchOption(Branch.minor);
                                      moveToBranch(Point(latitude: list[16].location.lat, longitude: list[16].location.long));
                                      context.read<OrderDetailProvider>().updateBranch(list[16].name);
                                      context.read<OrderDetailProvider>().updateAddress(list[16].address);
                                    },
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/images/branch.svg'),
                                          const SizedBox(width: 10,),
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(list[16].name,
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              Text(list[16].address,
                                                style: TextStyle(
                                                    fontSize: 12, color: Colors.grey[600]),
                                              ),
                                            ],
                                          )),
                                          CupertinoRadio<Branch>(
                                            value: Branch.minor,
                                            groupValue: branch,
                                            onChanged: (Branch? value) {},
                                            activeColor: Colors.deepPurple,
                                          ),
                                          const SizedBox(width: 5,)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } catch(e) {
                              return Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error, color: Colors.red,size: 40),
                                  Text('$e')
                                ],
                              ),
                              );
                            }
                          }
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15,left: 15,right: 15),
                        child: Text('To\'lov turi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            _paymentOption(PaymentMethod.cash);
                            context.read<OrderDetailProvider>().updatePaymentMethod('Naqd pul');
                          },
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                SvgPicture.asset('assets/images/cash.svg'),
                                const SizedBox(width: 10),
                                const Expanded(child: Text('Naqd pul')),
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
                      Divider(color: Colors.grey[300],height: 1, indent: 65),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            _paymentOption(PaymentMethod.payme);
                            context.read<OrderDetailProvider>().updatePaymentMethod('Payme');
                        },
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
                      Divider(color: Colors.grey[300],height: 1, indent: 65),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                              _paymentOption(PaymentMethod.click);
                              context.read<OrderDetailProvider>().updatePaymentMethod('Click');
                          },
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Chek', style: TextStyle(fontWeight: FontWeight.bold)),
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
                                Text('${data.amount} x ${data.price} so\'m', style: const TextStyle(color: Colors.grey,height: 1),)
                              ],
                            );
                          },
                        )
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Umumiy narxi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                          Text('${widget.totalPrice} so\'m', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
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
    );
  }
}
