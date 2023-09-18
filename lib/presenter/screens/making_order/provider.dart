import 'package:flutter/cupertino.dart';

class OrderDetailProvider extends ChangeNotifier {
  var branch = '';
  var address = '';
  var paymentMethod = 'Naqd pul';

  void updateBranch(String branchName) {
    branch = branchName;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updatePaymentMethod(String method) {
    paymentMethod = method;
    notifyListeners();
  }
}
