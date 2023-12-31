import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/model/model.dart';
import 'package:flutter_max_way/core/model/product_data.dart';
import 'package:flutter_max_way/presenter/screens/details/details_bloc.dart';

import '../../../core/di/hive_module.dart';
// import 'package:share_plus/share_plus.dart';

const BUTTON_ADD = "Add";
const BUTTON_TO_CART = "To Cart";

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ScrollController _scrollController;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  var productCount = 1;
  var buttonText = "Add";

  void inc() {
    productCount++;
    if (buttonText == "To Cart") {
      buttonText = "Add";
    }
    setState(() {});
  }

  void dec() {
    productCount--;
    if (buttonText == "To Cart") {
      buttonText = "Add";
    }
    setState(() {});
  }

  // late DetailsBloc bloc;

  @override
  void initState() {
    // bloc = getIt.get<DetailsBloc>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                scrolledUnderElevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                expandedHeight: 200,
                pinned: true,
                actions: [
                  GestureDetector(
                    onTap: () {
                      // Share.share("Dima",subject: "ksajfaksfj");
                    },
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: const Icon(Icons.share)),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text(widget.product.title.uz,
                  //     style: TextStyle(
                  //       color: isShrink ? Colors.black : Colors.white,
                  //       fontSize: 20.0,
                  //     )),
                  background: Image.network(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.title.uz),
                      Expanded(
                          child: Text(widget.product.description.uz.trim()))
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const Divider(height: 1),
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            height: 40,
                            width: 120,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: productCount > 1 ? dec : null,
                                    icon: const Icon(Icons.remove)),
                                SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Text(productCount.toString()),
                                  ),
                                ),
                                IconButton(
                                    onPressed: inc,
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
                          ),
                          Text(
                            "${widget.product.price * productCount} so'm",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if (buttonText == "To Cart") {
                            // bloc.add(AddProduct(
                            //     product: ProductData(
                            //         id: widget.product.id,
                            //         price: widget.product.price,
                            //         currency: widget.product.currency,
                            //         image: widget.product.image,
                            //         title: DescriptionData(
                            //             uz: widget.product.title.uz),
                            //         description: DescriptionData(
                            //             uz: widget.product.description.uz)
                            //     )
                            // )
                            // );
                          }

                          if (buttonText == "Add") {
                            buttonText = "To Cart";
                            setState(() {});
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF51267D)),
                            child: Center(
                                child: Text(
                              buttonText,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
