import 'package:flutter/material.dart';

import '../../core/model/model.dart';
import 'product.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70
            ),
            height: category.products.length * 90 + 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.title.uz, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                SizedBox(
                  height: category.products.length * 90 + 15,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: category.products.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0.5,height: 6.6),
                    itemBuilder: (_, ind) {
                      final product = category.products[ind];
                      return InkWell(
                          onTap: () {
                            print("BBBBBBBB ${product.title.uz}");
                          },
                          highlightColor: Colors.green,
                          child: ProductItem(product: product)
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}