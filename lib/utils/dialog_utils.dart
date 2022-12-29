import 'package:flutter/material.dart';

class DialogUtils {
  static void showProgressDialog(BuildContext context, String message,
      {bool isDismisable = true}) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 12),
                Text(message)
              ],
            ),
          );
        },
        barrierDismissible: isDismisable);
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessageDialog(BuildContext context, String message,
      {String? posActionTittle,
      String? negActionTittle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isDismisable = true}) {
    showDialog(
      barrierDismissible: isDismisable,
      context: context,
      builder: (buildContext) {
        List<Widget> actions = [];
        if (posActionTittle != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (posAction != null) {
                  posAction();
                }
              },
              child: Text(posActionTittle)));
        }
        if (negActionTittle != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (negAction != null) {
                  negAction();
                }
              },
              child: Text(negActionTittle)));
        }
        return AlertDialog(
          content: Text(message),
          actions: actions,
        );
      },
    );
  }
}
