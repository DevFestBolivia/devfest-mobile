import 'package:devfestbolivia/text_strings.dart';
import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(TextStrings.info),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text(TextStrings.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
