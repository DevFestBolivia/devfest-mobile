import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/validator_util.dart';
import 'package:devfestbolivia/widgets/input_email.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDialog {
  static void showForgotPasswordDialog(
      BuildContext context, Function sendForgotPassword) {
    final formKey = GlobalKey<FormState>();
    bool loading = true;
    String email = '';

    void onChangeEmail(String value) {
      email = value;
    }

    void forgotPassword() {
      formKey.currentState!.validate();
      if (ValidatorUtil().validateEmail(email).isValid) {
        sendForgotPassword(email);
        Navigator.of(context).pop();
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(TextStrings.forgotPassword),
          content: const Text(
            TextStrings.pleaseEnterYourEmail,
            style: TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            InputEmail(onChanged: (value) => email = value, formKey: formKey),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(TextStrings.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(TextStrings.ok),
                  onPressed: () {
                    forgotPassword();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
