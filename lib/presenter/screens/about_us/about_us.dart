import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "About Us",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context, CupertinoPageRoute(builder: (_) => DetailScreen(product: product)));
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 220,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We make customers happy",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      "The history of the MaxWay company operates in the fast-growing market of the Republic of Uzbekistan and is focused on meeting the growing market demand.The company has shown excellent result over the past 4 years and is growing steadily through ist core business: Food and Beverage.",
                                      style: TextStyle(fontSize: 15))),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
