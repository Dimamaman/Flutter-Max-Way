import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/presenter/screens/details/recommend.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/floor/database/database.dart';
import '../../../core/floor/entity/product_data.dart';
import '../../../core/model/model.dart';
import '../../../di/floor_module.dart';
import '../../bloc/details/details_bloc.dart';
import '../../utils/badges.dart';
import '../../utils/navigator.dart';
import '../../utils/toast.dart';
import '../cart/cart_page.dart';
import '../cart/cart_screen.dart';
import '../cart/cart_screen.dart';
import '../main_page.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  final Category recommended;

  const DetailScreen({super.key, required this.product, required this.recommended});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  final dao = getIt<AppDatabase>().productDao;
  late DetailsBloc bloc;
  var productCount = 1;

  @override
  void initState() {
    bloc = DetailsBloc(dao);
    bloc.add(LoadProduct(product: widget.product, alreadyHave: false,));
    super.initState();
  }

  Future<void> shareApp() async {
    // Set the app link and the message to be shared
    const String appLink = 'https://play.google.com/store/apps/details?id=com.example.myapp';
    const String message = 'Check out my new app: $appLink';

    // Share the app link and message using the share dialog
    await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      bloc: bloc,
      builder: (context, state) {
        productCount = state.productCount;
        if (state.isAdded) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          backgroundColor: Colors.white,
                          automaticallyImplyLeading: false,
                          scrolledUnderElevation: 0,
                          expandedHeight: 260,
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: BackButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                          ),
                          actions: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  await shareApp();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.share),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            background: CachedNetworkImage(
                              imageUrl: widget.product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title.uz,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.product.description.uz.trim(),
                                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title.uz,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.product.description.uz.trim(),
                                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title.uz,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.product.description.uz.trim(),
                                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Recommendation(deserts: widget.recommended)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                  )
                ],
              ),
              Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Material(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: Column(
                        children: [
                          Expanded(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.005),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey[300]!, width: 0.8, strokeAlign: BorderSide.strokeAlignOutside)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        padding: const EdgeInsets.all(5),
                                        onPressed: () {
                                          bloc.add(ProductDecrement(context: context, mustIncrement: true));
                                          // bloc.add(LoadProduct(product: widget.product, alreadyHave: true));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    SizedBox(
                                      width: 20,
                                      child: Center(
                                          child: Text(
                                        state.productCount.toString(),
                                        style: const TextStyle(fontSize: 17),
                                      )),
                                    ),
                                    IconButton(
                                        padding: const EdgeInsets.all(5),
                                        onPressed: () {
                                          bloc.add(ProductIncrement(mustIncrement: true));
                                          // bloc.add(LoadProduct(product: widget.product,alreadyHave: true));
                                        },
                                        icon: const Icon(Icons.add)),
                                  ],
                                ),
                              ),
                              Text(
                                 "${state.productData.price * state.productCount}  so\'m,",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            color: const Color(0xff51267D),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                if (state.isAdded && state.buttonMessage == "To Cart") {
                                  print("AAAAAAAAAAAAA");
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => const MainScreen(
                                                position: 1,
                                              )));
                                } else {
                                  print("BBBBBBBBBBBBBB");
                                  bloc.add(AddProduct(
                                      product: ProductData(
                                          productId: widget.product.id,
                                          price: widget.product.price,
                                          currency: widget.product.currency,
                                          image: widget.product.image,
                                          title: widget.product.title.uz,
                                          description: widget.product.description.uz,
                                          amount: productCount),
                                      context: context));
                                  // buttonText = "To Cart";
                                  bloc.add(LoadProduct(product: widget.product, alreadyHave: true));
                                  showToast(['Product added to Cart','Check the Cart'], context,gravity: ToastGravity.TOP);
                                  setState(() {});
                                }
                              },
                              child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.065,
                                  child: Center(
                                      child: Text( state.productData.amount == state.productCount ? 'To Cart' : state.buttonMessage, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)))),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ]),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          backgroundColor: Colors.white,
                          automaticallyImplyLeading: false,
                          scrolledUnderElevation: 0,
                          expandedHeight: 260,
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: BackButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                          ),
                          actions: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  await shareApp();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.share),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            background: CachedNetworkImage(
                              imageUrl: widget.product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title.uz,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.product.description.uz.trim(),
                                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title.uz,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.product.description.uz.trim(),
                                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title.uz,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.product.description.uz.trim(),
                                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title.uz,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.product.description.uz.trim(),
                                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Recommendation(deserts: widget.recommended)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                  )
                ],
              ),
              Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Material(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: Column(
                        children: [
                          Expanded(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.005),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey[300]!, width: 0.8, strokeAlign: BorderSide.strokeAlignOutside)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        padding: const EdgeInsets.all(5),
                                        onPressed: () {
                                          bloc.add(ProductDecrement(context: context, mustIncrement: false));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    SizedBox(
                                      width: 20,
                                      child: Center(
                                          child: Text(
                                        state.productCount.toString(),
                                        style: const TextStyle(fontSize: 17),
                                      )),
                                    ),
                                    IconButton(
                                        padding: const EdgeInsets.all(5),
                                        onPressed: () {
                                          bloc.add(ProductIncrement(mustIncrement: false));
                                        },
                                        icon: const Icon(Icons.add)),
                                  ],
                                ),
                              ),
                              Text(
                                "${widget.product.price * state.productCount} so'm",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            color: const Color(0xff51267D),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                if (state.buttonMessage == "To Cart") {
                                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => CartPage()));
                                }

                                if (state.buttonMessage == "Add") {
                                  bloc.add(AddProduct(
                                      product: ProductData(
                                          productId: widget.product.id,
                                          price: widget.product.price,
                                          currency: widget.product.currency,
                                          image: widget.product.image,
                                          title: widget.product.title.uz,
                                          description: widget.product.description.uz,
                                          amount: state.productCount),
                                      context: context));
                                  bloc.add(LoadProduct(product: widget.product, alreadyHave: true));
                                  showToast(['Product added to Cart','Check the Cart'], context,gravity: ToastGravity.TOP);
                                  // context.read<BadgeProvider>().increment();
                                }
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height * 0.065,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFF51267D)),
                                  child: Center(
                                      child: Text(
                                    state.buttonMessage,
                                    style: const TextStyle(color: Colors.white, fontSize: 15),
                                  ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ]),
          );
        }
      },
    );
  }
}
