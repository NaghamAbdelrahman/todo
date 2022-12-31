import 'package:flutter/material.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('To Do List'),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Edit Task',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        TextFormField(
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return 'Please enter a valid tittle';
                              }
                              return null;
                            },
                            controller: tittleController,
                            decoration: InputDecoration(
                              labelText: 'Tittle',
                            )),
                        TextFormField(
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return 'Please enter a valid description';
                              }
                              return null;
                            },
                            controller: descriptionController,
                            maxLines: 4,
                            minLines: 4,
                            decoration: InputDecoration(
                              labelText: 'description',
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Select Date :',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                showTaskDatePicker();
                              },
                              child: Text(
                                  '${MyDateUtils.formatTaskDate(selectedDate)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color:
                                              Theme.of(context).primaryColor))),
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              updateTask();
                            },
                            child: Text('Save Changes'),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                            ))
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
        lastDate: DateTime.now().add(Duration(days: 365)),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColor,
              ),
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

  void updateTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    await MyDatabase.updateTask(
        task, tittleController.text, descriptionController.text, selectedDate);
    Navigator.pop(context);
  }
}
