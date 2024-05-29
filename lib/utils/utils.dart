import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/components/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  // To show toast message
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }


  static void showFlushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          backgroundColor: Colors.red,
          title: AppConstants.appName,
          messageColor: Colors.amber,
          forwardAnimationCurve: Curves.decelerate,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
        )..show(context));
  }
  static void showFlushBarSuccessMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          backgroundColor: Colors.green,
          title: AppConstants.appName,
          messageColor: Colors.white,
          forwardAnimationCurve: Curves.decelerate,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.check,
            size: 28,
            color: Colors.white,
          ),
        )..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode focusNodeNext) {
    current.unfocus();
    FocusScope.of(context).requestFocus(focusNodeNext);
  }

  static int randomNumberGenerator(BuildContext context) {
    Random random = Random();
    return random.nextInt(90000) + 1000;
  }

  static void printLogs(String message){
    if (kDebugMode) {
      print(message);
    }
  }
}
