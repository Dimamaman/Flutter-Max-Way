import 'package:flutter/material.dart';
import 'package:flutter_max_way/core/model/branch_model.dart';

class BranchItem extends StatelessWidget {
  Branch branch;

  BranchItem({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset('assets/images/maxway_purple.png', height: 65, width: 50),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    branch.name,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black,overflow: TextOverflow.ellipsis),
                  ),

                  Text(
                    branch.address,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0, color: Colors.black, overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
            ),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
