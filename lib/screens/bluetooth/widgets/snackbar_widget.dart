import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs
enum Status { success, warning, error }

class CustomSnackbar {
  CustomSnackbar(BuildContext context,
      {required String text, required Status status}) {
    Color color;

    switch (status) {
      case Status.success:
        color = const Color(0xFF007E33);
        break;
      case Status.warning:
        color = const Color(0xFFFF8800);
        break;
      case Status.error:
        color = const Color(0xFFCC0000);
        break;
    }

    Flushbar(
      messageText: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
      ),
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: color,
    ).show(context);
  }
}
