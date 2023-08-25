import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/model/description_model.dart';
import 'package:flutter_max_way/core/model/product_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/navigator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final Box<ProductData> box;

  @override
  void initState() {
    print("NNNNNNNNNNN Cart initState");
    box = Hive.box<ProductData>(dbName);
    super.initState();
  }

  @override
  void dispose() {
    box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, items, child) {
            List<int> keys = items.keys.cast<int>().toList();

            return keys.isEmpty
                ? const Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: keys.length,
                    itemBuilder: (_, index) {
                      final int key = keys[index];
                      final ProductData productData = items.get(key) ??
                          ProductData(
                            title: DescriptionData(uz: ''),
                            description: DescriptionData(uz: ''),
                            id: '',
                            price: 23,
                            image: "",
                            currency: '',
                          );
                      return Card(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        margin: const EdgeInsets.all(10),
                        elevation: 2,
                        child: ListTile(
                          title: Text(productData.title.uz),
                          subtitle: Text(productData.description.uz),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit button
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => {}),
                              // Delete button
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => {}),
                            ],
                          ),
                        ),
                      );
                    });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
