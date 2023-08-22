import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/core/model/model.dart';
import 'package:flutter_max_way/presenter/bloc/food_bloc.dart';
import 'package:flutter_max_way/presenter/pref/location_pref.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/api/food_api.dart';
import 'category.dart';
import 'map_page.dart';

class MainScreen extends StatefulWidget {
  var a = false;
  MainScreen({super.key, required this.a});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var category = <Category>[];
  final bloc = FoodBloc(FoodApi());
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final pref = LocationPref();
  var haveLocation = false;
  var locationName = '';

  @override
  void initState() {
    print("PPPPPPPPPPP");
    bloc.add(LoadFoodEvent(null));
    getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    print("HHHHHHHHHHHHHHHHHHHHH");
    haveLocation = await pref.getIsFirst();
    locationName = await pref.getPosition();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(widget.a) {
      setState(() {});
      print("TTTTTTTTTTTTTTTTTTTT");
    } else {
      setState(() {});
      print("RRRRRRRRRRRRRRRRR");
    }
    return BlocBuilder<FoodBloc, FoodState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                    child: haveLocation
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Map_Page();
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Yetkazib berish",
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          locationName,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Map_Page();
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text("Manzilni qo'shing"),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      // onEditingComplete: () {
                      //   context.read<BookProvider>().loadData(searchValue);
                      // },
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Qidirish',
                        prefixIcon:
                            const Icon(Icons.search, color: Color(0xFFC4C4C4)),
                        hintStyle: const TextStyle(
                          color: Color(0xFFC4C4C4),
                          fontSize: 14.5,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.grey,
                                ))
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListView.builder(
                          itemCount: state.list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final category = state.list[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFFFFFFF),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(category.title.uz),
                                )),
                              ),
                            );
                          })),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        separatorBuilder: (__, _) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: state.list.length,
                        itemBuilder: (_, i) {
                          final category = state.list[i];
                          return CategoryItem(category: category);
                        },
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
