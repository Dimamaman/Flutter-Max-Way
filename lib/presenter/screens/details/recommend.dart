
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/model/model.dart';


class Recommendation extends StatelessWidget {
  const Recommendation({
    super.key,
    required this.deserts,
  });

  final Category? deserts;

  @override
  Widget build(BuildContext context) {
    print("YYYYYYYYYYY ${deserts?.products.length}");
    return Container(                  //RECOMMENDATIONS
      width: double.infinity,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RECOMMENDATIONS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16),),
          const SizedBox(height: 10,),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (__, _) => const SizedBox(width: 8),
              itemCount: deserts!.products.length,
              itemBuilder: (context, index) {
                final product = deserts!.products[index];
                return Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF6F6F6),
                  child: InkWell(
                    onTap: (){},
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset('assets/images/image 105.png', color: Colors.grey[400], fit: BoxFit.cover,),
                            ),
                          ),
                          Expanded(child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(product.title.uz, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                Text(product.description.uz.trim(), maxLines: 2, style: const TextStyle(
                                    color: Colors.grey, fontSize: 12, height: 1.2, overflow: TextOverflow.ellipsis),),
                              ],
                            )
                          )),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              height: 30,
                              child: Center(
                                child: Text('${product.price} so\'m', style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
