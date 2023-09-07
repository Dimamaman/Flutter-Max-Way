import 'package:flutter/cupertino.dart';

class OrderDetailProvider extends ChangeNotifier{

  var branchName = 'MAX WAY MEGA PLANET';
  var paymentMethod = 'Naqd pul';

  void updateBranchName(String name){
    branchName = name;
    notifyListeners();
  }

  void updatePaymentMethod(String method){
    paymentMethod = method;
    notifyListeners();
  }

}