import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/presenter/screens/product_search.dart';
import 'package:flutter_max_way/presenter/screens/shimmer.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/api/food_api.dart';
import '../../core/model/model.dart';
import '../bloc/food_bloc.dart';
import '../pref/location_pref.dart';
import 'category.dart';
import 'map_page.dart';

class Home_Page extends StatefulWidget {
  var a = false;

  Home_Page({super.key, required this.a});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  var category = <Category>[];
  final bloc = FoodBloc(FoodApi());
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final pref = LocationPref();
  var isFirst = false;
  var locationName = '';
  var searchValueEmpty = false;

  @override
  void initState() {
    bloc.add(LoadFoodEvent());
    getLocation();

    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        searchValueEmpty = true;
        bloc.add(LoadFoodEvent());
      } else {
        searchValueEmpty = false;
        bloc.add(SearchFoodEvent(_searchController.text));
      }
    });

    super.initState();
  }

  Future<void> getLocation() async {
    isFirst = await pref.getIsFirst();
    print("JJJJJJJJJJJ -> $isFirst");
    locationName = await pref.getPosition();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.a) {
      setState(() {});
    } else {
      setState(() {});
    }

    var selectedCategories = <String>[];

    return BlocBuilder<FoodBloc, FoodState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                    child: isFirst
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text("Add Address"),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          )
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Delivery",
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
                            ))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEFEFEF),
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
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: Builder(builder: (context) {
                    if (state.status == EnumStatus.loading &&
                        state.list.isEmpty) {
                      return ListView.separated(
                          itemCount: 10,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          itemBuilder: (_, index) {
                            return Container(
                              height: 40,
                              width: 150,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFFFFFFF),
                              ),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.1),
                                highlightColor: Colors.grey.withOpacity(0.3),
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          });
                    }
                    return ListView.builder(
                        itemCount: state.categoryTitle.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        itemBuilder: (_, index) {
                          final category = state.categoryTitle[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedCategories.contains(category)) {
                                  selectedCategories.remove(category);
                                } else {
                                  selectedCategories.add(category);
                                }

                                if (selectedCategories.isEmpty) {
                                  bloc.add(LoadFoodEvent());
                                }

                                bloc.add(
                                    SearchByTitleEvent(selectedCategories));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedCategories.contains(category)
                                        ? const Color(0xFF51267D)
                                        : const Color(0xFFEFEFEF)),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                        color: selectedCategories
                                                .contains(category)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )),
                              ),
                            ),
                          );
                        });
                  }),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    if (state.status == EnumStatus.loading) {
                      return const SingleChildScrollView(child: ShimmerView());
                    }

                    if (_searchController.text.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 10),
                            itemCount: state.list[0].products.length,
                            itemBuilder: (_, index) {
                              final product = state.list[0].products[index];
                              return ProductSearchItem(product: product);
                            }),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 10),
                      separatorBuilder: (__, _) => const SizedBox(
                        height: 15,
                      ),
                      itemCount: state.list.length,
                      itemBuilder: (_, i) {
                        final category = state.list[i];
                        return CategoryItem(category: category, isFirst: isFirst,);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
