import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/details/details_page.dart';
import 'package:flutter_max_way/presenter/screens/map_page.dart';

import '../../core/model/model.dart';
import 'product.dart';

class CategoryItem extends StatelessWidget {
  final bool isFirst;
  const CategoryItem({
    super.key,
    required this.category,
    required this.isFirst
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFEFEFEF)
            ),
            height: category.products.length * 90 + 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(category.title.uz, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: category.products.length * 90 + 15,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: category.products.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0.5,height: 6.6),
                    itemBuilder: (_, ind) {
                      final product = category.products[ind];
                      return InkWell(
                          onTap: () {
                            isFirst ? Navigator.push(context, CupertinoPageRoute(builder: (context) => const Map_Page())) :
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => DetailPage(product: product)));
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