import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  const ShimmerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.1),
            highlightColor: Colors.grey.withOpacity(0.3),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.2,
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * 0.24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.2,
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * 0.24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.2,
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * 0.24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.2,
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * 0.24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.2,
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * 0.24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.3),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * 0.24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
