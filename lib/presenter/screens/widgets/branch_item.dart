
import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/model/branch_model.dart';

class BranchItem extends StatelessWidget {
  BranchModel branchModel;

  BranchItem({super.key, required this.branchModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(branchModel.image,height: 50,width: 50),

          const SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(branchModel.title, style: const TextStyle(color: Colors.black)),

              Text(branchModel.street),
            ],
          ),

          const Spacer(),

          const Icon(Icons.navigate_next),

          const SizedBox(width: 5)
        ],
      ),
    );
  }
}
