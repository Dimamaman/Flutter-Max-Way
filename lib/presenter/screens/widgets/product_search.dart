import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/details/detail_screen.dart';

import '../../../core/model/model.dart';

class ProductSearchItem extends StatelessWidget {
  const ProductSearchItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (_) => DetailScreen(product: product)));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(10),
          height: 70,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 0.6,strokeAlign: BorderSide.strokeAlignOutside)
                  ),
                  child: Image.network(product.image, fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(product.title.uz, style: const TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)
                    ),
                    Text("${product.price} so'm", style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
