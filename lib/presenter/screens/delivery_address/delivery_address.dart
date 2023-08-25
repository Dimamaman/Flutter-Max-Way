
import 'package:flutter/material.dart';

class Delivery_Address extends StatefulWidget {
  final String pinnedLocation;
  const Delivery_Address({super.key, required this.pinnedLocation});

  @override
  State<Delivery_Address> createState() => _Delivery_AddressState();
}

class _Delivery_AddressState extends State<Delivery_Address> {

  var _addressController = TextEditingController();
  var _apartmentController = TextEditingController();
  var _entranceController = TextEditingController();
  var _floorController = TextEditingController();
  FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFF8F6FA)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  width: 351,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(widget.pinnedLocation),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                /*Container(
                  width: 351,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),*/

                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        TextField(
                          controller: _addressController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixIcon: _addressController.text.isNotEmpty ? IconButton(onPressed: () {
                              _addressController.clear();
                              setState(() {});
                            },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.grey,
                                )
                            ): null,
                            hintText: 'Название адреса',
                            hintStyle: const TextStyle(
                              color: Color(0xFFC4C4C4),
                              fontSize: 14,
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              TextField(
                                controller: _apartmentController,
                                // focusNode: _focusNode,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  suffixIcon: _apartmentController.text.isNotEmpty ? IconButton(onPressed: () {
                                    _apartmentController.clear();
                                    setState(() {});
                                  },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                      )
                                  ): null,
                                  hintText: 'Квартира',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 14,
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              TextField(
                                controller: _entranceController,
                                // focusNode: _focusNode,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  suffixIcon: _entranceController.text.isNotEmpty ? IconButton(onPressed: () {
                                    _entranceController.clear();
                                    setState(() {});
                                  },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                      )
                                  ): null,
                                  hintText: 'Подьезд',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 14,
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10,),

                    Expanded(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              TextField(
                                controller: _floorController,
                                // focusNode: _focusNode,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  suffixIcon: _floorController.text.isNotEmpty ? IconButton(onPressed: () {
                                    _floorController.clear();
                                    setState(() {});
                                  },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                      )
                                  ): null,
                                  hintText: 'Этаж',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 14,
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                Spacer(),

                Container(
                  width: 351,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: Color(0xFF51267D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                    'Добавить адрес',
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

                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
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