import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BranchesShimmerOrder extends StatelessWidget {
  const BranchesShimmerOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                          height: 28,
                          width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 50, color: Colors.grey[300]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          color: Colors.white,
                            height: 28,
                            width: 40
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.1),
                        highlightColor: Colors.grey.withOpacity(0.3),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height:18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
