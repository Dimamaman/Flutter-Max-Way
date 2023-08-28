
import 'package:flutter/material.dart';
class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {

  bool isRusClicked = false;
  bool isUzClicked = false;
  bool isEngClicked = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 290,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
            color: Colors.white
        ),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10,left: 20,bottom: 10),
                child: Text("Language",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
              ),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isUzClicked = false;
                    isRusClicked = true;
                    isEngClicked = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 23, // Image radius
                        backgroundImage: AssetImage(
                          'assets/images/rus5.png',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                          child: Text(
                            'Русский',
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                          child: isRusClicked ? const Icon(
                            Icons.check,
                            size: 25,
                          ) : null
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isUzClicked = true;
                    isRusClicked = false;
                    isEngClicked = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 23, // Image radius
                        backgroundImage: AssetImage(
                          'assets/images/uzb3.png',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                          child: Text(
                            "O'zbekcha",
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                          child: isUzClicked ? const Icon(
                            Icons.check,
                            size: 25,
                          ) : null
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isRusClicked = false;
                    isUzClicked = false;
                    isEngClicked = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 23, // Image radius
                        backgroundImage: AssetImage(
                          'assets/images/uk1.webp',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                          child: Text(
                            'English',
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                          child: isEngClicked ? const Icon(
                            Icons.check,
                            size: 25,
                          ) : null
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}