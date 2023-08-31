import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(List<String> message, BuildContext context, {Color color = Colors.white, ToastGravity gravity = ToastGravity.BOTTOM}) {
  final FToast toast = FToast();

  toast.init(context);

  Widget toast1 = Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: message.length == 2
        ? Column(
            children: [
              const Icon(Icons.check),
              const SizedBox(
                width: 12.0,
              ),
              Text(message[0]),
              Text(message[1]),
            ],
          )
        : Center(child: Text(message[0])),
  );

  toast.showToast(child: toast1, gravity: gravity, toastDuration: const Duration(seconds: 2));
}
