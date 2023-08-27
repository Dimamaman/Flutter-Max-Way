import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_max_way/core/api/food_api.dart';
import 'package:flutter_max_way/presenter/bloc/branches/branches_bloc.dart';
import 'package:flutter_max_way/presenter/screens/branches/branch_page.dart';
import 'package:flutter_max_way/presenter/screens/widgets/branch_item.dart';
import 'package:flutter_max_way/presenter/screens/widgets/branches_shimmer.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  final bloc = BranchesBloc(FoodApi());

  @override
  void initState() {
    bloc.add(LoadBranches());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesBloc, BranchesState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.status == UIStatus.loading && state.list.isEmpty) {
          return Scaffold(
              backgroundColor: const Color(0xFFF6F6F6),
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  "Filiallar",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
              body: const SingleChildScrollView(child: BranchesShimmer()));
        }
        return Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                "Filiallar",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: state.list.length * 70 + 80,
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var branch = state.list[index];
                        return Material(
                          color: Colors.white,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute(builder: (_) => BranchPage(branch: branch)));
                              },
                              child: BranchItem(branch: branch)),
                        );
                      },
                      separatorBuilder: (__, _) => const Divider(height: 5,indent: 12,endIndent: 12,),
                      itemCount: state.list.length),
                ),
              ),
            ));
      },
    );
  }
}
