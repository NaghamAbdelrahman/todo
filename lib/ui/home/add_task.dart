import 'package:flutter/material.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/utils/date_utils.dart';
import 'package:todo/utils/dialog_utils.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var tittleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new task',
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
                  child: Text('${MyDateUtils.formatTaskDate(selectedDate)}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).primaryColor))),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  insertTask();
                },
                child: Text('Submit'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ))
          ],
        ),
      ),
    );
  }

  void insertTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialogUtils.showProgressDialog(context, 'Loading...', isDismisable: false);
    try {
      await MyDatabase.insertTask(Task(
          tittle: tittleController.text,
          description: descriptionController.text,
          dateTime: selectedDate));
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context, 'Task inserted successfully',
          posActionTittle: 'Ok', posAction: () {
        Navigator.pop(context);
      }, isDismisable: false);
    } catch (e) {
      await MyDatabase.insertTask(Task(
          tittle: tittleController.text,
          description: descriptionController.text,
          dateTime: selectedDate));
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context, 'Error inserting task',
          posActionTittle: 'Try Again',
          posAction: () {
            insertTask();
          },
          negActionTittle: 'Cancel',
          negAction: () {
            Navigator.pop(context);
          },
          isDismisable: false);
    }
  }

  var selectedDate = DateTime.now();

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
}
