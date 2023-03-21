import 'package:flutter/material.dart';

abstract class BaseNavigator {
  hideDialog();

  showMessageDialog(String message,
      {String? posActionTittle,
      String? negActionTittle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isDismisable = true});

  showProgressDialog(String message, {bool isDismisable = true});
}

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
}
