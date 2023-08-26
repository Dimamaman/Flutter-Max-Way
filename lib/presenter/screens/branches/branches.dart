import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/presenter/bloc/branches/branches_bloc.dart';
import 'package:flutter_max_way/presenter/bloc/branches/branches_bloc.dart';
import 'package:flutter_max_way/presenter/screens/widgets/branch_item.dart';

import '../../../core/model/branch_model.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  var list = [
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
    BranchModel(image: 'assets/images/image 105.png', title: "MAX WAY AVIASOZLAR", street: "Magic City"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Filiallar",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return BranchItem(branchModel: list[index]);
                    },
                    separatorBuilder: (__, _) => const Divider(height: 5),
                    itemCount: list.length),
              ),
            ),
          )),
    );
  }
}
