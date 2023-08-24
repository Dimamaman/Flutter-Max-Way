
import 'package:flutter/material.dart';
import 'package:flutter_max_way/main.dart';

Future<dynamic> push(Widget widget) async {
  return await Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => widget));
}

void pop([dynamic result]) {
  Navigator.pop(navigatorKey.currentContext!,result);
}