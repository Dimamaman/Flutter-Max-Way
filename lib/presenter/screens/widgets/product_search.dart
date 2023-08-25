import 'package:flutter/material.dart';
import 'package:flutter_max_way/presenter/screens/details/details_page.dart';
import 'package:flutter_max_way/presenter/utils/navigator.dart';

import '../../../core/model/model.dart';



class ProductSearchItem extends StatelessWidget {
  const ProductSearchItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      height: 70,
      child: InkWell(
        onTap: () {
          // push(DetailPage(product: product));
          Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(product: product)));
        },
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
    );
  }
}
