import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/presenter/bloc/cart/cart_bloc.dart';
import 'package:flutter_max_way/presenter/screens/main_screen.dart';
import '../../../core/floor/dao/product_dao.dart';
import '../../../core/floor/database/database.dart';
import '../../../core/floor/entity/product_data.dart';
import '../../../di/floor_module.dart';
import '../../utils/badges.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  final _productDao = getIt<AppDatabase>().productDao;
  List<ProductData> products = [];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isEmpty = true;
  late CartBloc bloc;

  var finalCost = 0;

  void _delete(String id) {
    try {
      widget._productDao.deleteProduct(id);
    } catch (e) {
      // showToast(['$e'], context);
    }
    setState(() {});
  }

  Future<ProductDao> _callProducts() async {
    return widget._productDao;
  }

  @override
  void initState() {
    bloc = CartBloc(widget._productDao);
    bloc.add(FetchProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(milliseconds: 50)).then((value) {
    //   setState(() {});
    // });

    return BlocBuilder<CartBloc, CartState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: const Text(
              'Savatcha',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: isEmpty
                ? []
                : [
                    IconButton(
                        onPressed: () {
                          widget._productDao.deleteAll();
                          context.read<BadgeProvider>().updateBadgeValue(0);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.blueGrey,
                        )),
                    const SizedBox(
                      width: 10,
                    )
                  ],
          ),
          body: SafeArea(
            child: Builder(builder: (context) {
              return Column(children: [
                Expanded(
                  child: Builder(builder: (context) {
                    print("FFFFFFFFFF");

                    // if (state.state == UIState.loading) {
                    //   return const Center(child: CircularProgressIndicator());
                    // }

                    return FutureBuilder(
                        future: widget._productDao.getAllProducts(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
                            return const Center(
                                child: CupertinoActivityIndicator(
                                  radius: 20,
                                  color: Color(0xff51267D),
                                ));
                          }
                          return ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var product = state.list[index];
                                var a = snapshot.data![index].description;
                                print("FFFFFFFFFF $a");
                                return ListTile(
                                  title: Text(product.title),
                                );
                              });
                        });
                  }),
                ),
                // Container(
                //   color: Colors.white,
                //   padding: const EdgeInsets.all(15),
                //   height: state.list.isNotEmpty ? MediaQuery.of(context).size.height * 0.12 : MediaQuery.of(context).size.height * 0.16,
                //   child: state.list.isNotEmpty
                //       ? Column(
                //           children: [
                //             Expanded(
                //                 child: Row(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 const Text(
                //                   'Buyurtma narxi',
                //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                //                 ),
                //                 Text(
                //                   '$finalCost so\'m',
                //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                //                 )
                //               ],
                //             )),
                //             const SizedBox(
                //               height: 10,
                //             ),
                //             Material(
                //               clipBehavior: Clip.antiAlias,
                //               color: const Color(0xff51267D),
                //               borderRadius: BorderRadius.circular(10),
                //               child: InkWell(
                //                 onTap: () {
                //                   Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const MainScreen()));
                //                 },
                //                 child: SizedBox(
                //                     height: MediaQuery.of(context).size.height * 0.065,
                //                     child: const Center(child: Text('Buyurtmani rasmiylashtirish', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)))),
                //               ),
                //             )
                //           ],
                //         )
                //       : Material(
                //           color: const Color(0xff51267D),
                //           borderRadius: BorderRadius.circular(10),
                //           child: InkWell(
                //             borderRadius: BorderRadius.circular(10),
                //             onTap: () {
                //               Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const MainScreen()));
                //             },
                //             child: SizedBox(
                //                 height: MediaQuery.of(context).size.height * 0.065,
                //                 child: Center(
                //                     child: Text(state.list.isNotEmpty ? 'Buyurtmani rasmiylashtirish' : 'Mahsulot qo\'shing',
                //                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)))),
                //           ),
                //         ),
                // )
              ]);
            }),
          ),
        );
      },
    );
  }
}
