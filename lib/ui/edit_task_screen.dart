import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';

import '../providers/settings_provider.dart';
import '../utils/date_utils.dart';

class EditTaskScreen extends StatefulWidget {
  static String routeName = 'editTak';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var formKey = GlobalKey<FormState>();
  var tittleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();
  late Task task;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      task = ModalRoute.of(context)?.settings.arguments as Task;
      tittleController.text = task.tittle;
      descriptionController.text = task.description;
      selectedDate = task.dateTime;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.toDoList),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenSize.height * 0.1,
                color: Theme.of(context).primaryColor,
              ),
              Center(
                child: Container(
                  height: screenSize.height * 0.7,
                  width: screenSize.width * 0.8,
                  margin: EdgeInsets.only(top: screenSize.height * 0.05),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.editTask,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        TextFormField(
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .tittleValidation;
                              }
                              return null;
                            },
                            controller: tittleController,
                            style: TextStyle(
                                color: settingsProvider.currentTheme ==
                                        ThemeMode.light
                                    ? Colors.black
                                    : Colors.white),
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.tittle,
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: settingsProvider.lightMood()
                                          ? Colors.grey
                                          : Colors.white),
                                ))),
                        TextFormField(
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .descriptionValidation;
                              }
                              return null;
                            },
                            controller: descriptionController,
                            maxLines: 4,
                            minLines: 4,
                            style: TextStyle(
                                color: settingsProvider.currentTheme ==
                                        ThemeMode.light
                                    ? Colors.black
                                    : Colors.white),
                            decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context)!.description,
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: settingsProvider.lightMood()
                                          ? Colors.grey
                                          : Colors.white),
                                ))),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        Text(
                          AppLocalizations.of(context)!.selectDate,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                showTaskDatePicker();
                              },
                              child: Text(
                                  MyDateUtils.formatTaskDate(
                                      selectedDate, context),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color:
                                              Theme.of(context).primaryColor))),
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              updateTask();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                            ),
                            child:
                                Text(AppLocalizations.of(context)!.saveChanges))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

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

  void updateTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    await MyDatabase.updateTask(
        task, tittleController.text, descriptionController.text, selectedDate);
    Navigator.pop(context);
  }
}
