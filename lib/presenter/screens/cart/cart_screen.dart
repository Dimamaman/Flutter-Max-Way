
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/presenter/screens/main_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/floor/dao/dao.dart';
import '../../../core/floor/database/database.dart';
import '../../../core/floor/entity/product_data.dart';
import '../../../di/floor_module.dart';
import '../../utils/badges.dart';
import '../../utils/navigator.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  final _productDao = getIt<AppDatabase>().productDao;
  List<ProductData> products = [];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  bool isEmpty = true;

  var finalCost = 0;

  void _delete(String id) {
    try{
      widget._productDao.deleteTodo(id);
    }catch(e){
      // showToast(['$e'], context);
    }
    setState(() {});
  }

  Future<ProductDao> _callProducts() async {
    return widget._productDao;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {});
    });

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
        actions: isEmpty ? [] : [
          IconButton(onPressed: () {
                widget._productDao.deleteAll(widget.products);
                context.read<BadgeProvider>().updateBadgeValue(0);
                setState(() {});
            }, icon: const Icon(Icons.delete_outline, color: Colors.blueGrey,)),
          const SizedBox(width: 10,)
        ],
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: _callProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return StreamBuilder(
                    stream: snapshot.data!.streamedData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (widget.products.length != snapshot.data!.length) {
                          widget.products = snapshot.data!;
                          var cost = 0;

                          for(var product in widget.products){
                            cost += product.price * product.amount;
                          }
                          finalCost = cost;

                          if(widget.products.isEmpty){ isEmpty = true; }
                          else { isEmpty = false; }
                        }
                        if (snapshot.data!.isEmpty) {
                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 110,child: Image.asset('assets/images/image 105.png')),
                              const SizedBox(height: 30),
                              const Text('Savatda hali mahsulot yo\'q'),
                            ],
                          ));
                        }
                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(snapshot.data![index].title),
                                subtitle: Text("${snapshot.data![index].amount.toString()}    ${snapshot.data![index].price.toString() }  so'm",
                                  style: const TextStyle(fontSize: 10),
                                ),
                                trailing: SizedBox(
                                  width: 50,
                                  child: IconButton(
                                    onPressed: () {
                                      _delete(snapshot.data![index].productId);
                                      // var a = Provider.of<BadgeProvider>(context, listen: false).badgeValue;
                                      // context.read<BadgeProvider>().updateBadgeValue(a--);
                                      print("NNNNNNN   Data Lenght ${snapshot.data!.length - 1}");
                                      context.read<BadgeProvider>().updateBadgeValue(snapshot.data!.length - 1);
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                    );
              }
            },
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          height: widget.products.isEmpty ? MediaQuery.of(context).size.height * 0.10 : MediaQuery.of(context).size.height * 0.16,
          child:  widget.products.isNotEmpty
              ? Column(
                children: [
                  Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Buyurtma narxi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '$finalCost so\'m',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Material(
                    clipBehavior: Clip.antiAlias,
                    color: const Color(0xff51267D),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const MainScreen()));
                      },
                      child: const SizedBox(
                          height: 54,
                          child: Center(
                              child: Text(
                                  'Buyurtmani rasmiylashtirish',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white)))),
                    ),
                  )
                ],
              )
          : Material(
            color: const Color(0xff51267D),
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const MainScreen()));
              },
              child: SizedBox(
                  height: 54,
                  child: Center(
                      child: Text(
                          widget.products.isNotEmpty ? 'Buyurtmani rasmiylashtirish' : 'Mahsulot qo\'shing',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white)))),
            ),
          ),
        )
      ]),
    );
  }
}
