import 'package:flutter/material.dart';
import 'package:todo/ui/base/base_viewModel.dart';

import '../../utils/dialog_utils.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  VM initViewModel();

  @override
  hideDialog() {
    DialogUtils.hideDialog(context);
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  showMessageDialog(String message,
      {String? posActionTittle,
      String? negActionTittle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isDismisable = true}) {
    DialogUtils.showMessageDialog(context, message,
        posActionTittle: posActionTittle,
        posAction: posAction,
        negActionTittle: negActionTittle,
        negAction: negAction,
        isDismisable: isDismisable);
  }

  @override
  showProgressDialog(String message, {bool isDismisable = true}) {
    DialogUtils.showProgressDialog(context, message,
        isDismisable: isDismisable);
  }
}
