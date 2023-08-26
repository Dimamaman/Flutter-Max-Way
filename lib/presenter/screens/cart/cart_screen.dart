import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/model/description_model.dart';
import 'package:flutter_max_way/core/floor/entity/product_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/floor/dao/dao.dart';
import '../../../core/floor/database/database.dart';
import '../../../di/floor_module.dart';
import '../../utils/navigator.dart';

class CartScreen extends StatefulWidget {

  final ProductDao _productDao = getIt<AppDatabase>().productDao;
  List<ProductData> todoList = [];

  final database = $FloorAppDatabase.databaseBuilder('flutter_database.db').build();

  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
        body: FutureBuilder(
          future: _callProducts(),
          builder: (BuildContext context, AsyncSnapshot<ProductDao> snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
              return const Center(child:  CircularProgressIndicator());
            } else {
              return StreamBuilder(
                stream: snapshot.data!.streamedData(),
                builder: (BuildContext context, AsyncSnapshot<List<ProductData>> snapshot) {
                  if (!snapshot.hasData || snapshot.connectionState == ConnectionState.none) {
                    return const Center(child:  CircularProgressIndicator());
                  } else {
                    if (widget.todoList.length != snapshot.data!.length) {
                      widget.todoList = snapshot.data!;
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Data Found'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(snapshot.data![index].title),
                                subtitle: Text(
                                  snapshot.data![index].description,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {

                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _deleteTask(snapshot.data![index].productId);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            }
          },
        ),
    );
  }

  void _deleteTask(String id) {
    widget._productDao.deleteTodo(id);
    setState(() {});
  }

  Future<ProductDao> _callProducts() async {
    return widget._productDao;
  }
}
