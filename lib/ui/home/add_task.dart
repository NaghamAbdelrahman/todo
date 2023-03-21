import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/di.dart';
import 'package:todo/ui/base/base_state.dart';
import 'package:todo/ui/home/home_viewModel.dart';
import 'package:todo/utils/date_utils.dart';
import 'package:todo/utils/dialog_utils.dart';

import '../../providers/settings_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends BaseState<AddTask, HomeViewModel>
    implements HomeNavigator {
  var formKey = GlobalKey<FormState>();
  var tittleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  HomeViewModel initViewModel() {
    // TODO: implement initViewModel
    return HomeViewModel(injectTasksRepository());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              TextFormField(
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return AppLocalizations.of(context)!.tittleValidation;
                  }
                  return null;
                },
                controller: tittleController,
                style: TextStyle(
                    color: settingsProvider.currentTheme == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.tittle,
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              settingsProvider.currentTheme == ThemeMode.light
                                  ? Colors.grey
                                  : Colors.white),
                    )),
              ),
              TextFormField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .descriptionValidation;
                    }
                    return null;
                  },
                  controller: descriptionController,
                  style: TextStyle(
                      color: settingsProvider.currentTheme == ThemeMode.light
                          ? Colors.black
                          : Colors.white),
                  maxLines: 4,
                  minLines: 4,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.description,
                      labelStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                settingsProvider.currentTheme == ThemeMode.light
                                    ? Colors.grey
                                    : Colors.white),
                      ))),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.selectDate,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 11,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      showTaskDatePicker();
                    },
                    child: Text(
                        MyDateUtils.formatTaskDate(selectedDate, context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Theme.of(context).primaryColor))),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    insertTask();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  child: Text(AppLocalizations.of(context)!.submit))
            ],
          ),
        ),
      ),
    );
  }

  void insertTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.saveTask(
        tittleController.text, descriptionController.text, selectedDate);
  }

  var selectedDate = DateTime.now();
  void showTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          var settingsProvider = Provider.of<SettingsProvider>(context);
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: settingsProvider.currentTheme == ThemeMode.light
                  ? lightScheme()
                  : darkScheme(),
              dialogBackgroundColor: Theme.of(context).accentColor,
            ),
            child: child!,
          );
        });
    if (userSelectedDate == null) {
      return;
    }
    setState(() {
      selectedDate = userSelectedDate;
    });
  }

  ColorScheme darkScheme() {
    return ColorScheme.dark(
      primary: Theme.of(context).primaryColor,
      onPrimary: Theme.of(context).accentColor,
      surface: Theme.of(context).primaryColor,
    );
  }

  ColorScheme lightScheme() {
    return ColorScheme.light(
      primary: Theme.of(context).primaryColor,
      onPrimary: Theme.of(context).accentColor,
      surface: Theme.of(context).primaryColor,
    );
  }

  @override
  hideDialog() {
    DialogUtils.hideDialog(context);
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
