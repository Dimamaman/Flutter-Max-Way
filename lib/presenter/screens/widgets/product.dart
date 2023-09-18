import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/model/model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title.uz,style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
                Text(product.description.uz.trim(),maxLines: 2,style: const TextStyle(overflow: TextOverflow.ellipsis)),
                const SizedBox(height: 5),
                Text("${product.price.toString().substring(0,product.price.toString().length - 3)} 000 so'm",style: const TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          const SizedBox(width: 5),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset('assets/images/placeholder.png', color: Colors.grey[400], fit: BoxFit.cover,)
                ),

            ),
          )

        ],
      ),
    );
  }
}
