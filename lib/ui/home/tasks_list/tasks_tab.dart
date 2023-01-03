import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/providers/settings_provider.dart';
import 'package:todo/ui/home/tasks_list/task_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenSize.height * 0.1,
              color: Theme.of(context).primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: screenSize.height * 0.03),
              child: DatePicker(
                DateTime.now(),
                width: 70,
                height: 90,
                initialSelectedDate: selectedDate,
                monthTextStyle: TextStyle(
                    color: settingsProvider.lightMood()
                        ? Colors.black
                        : Colors.white),
                dateTextStyle: TextStyle(
                    color: settingsProvider.lightMood()
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
                dayTextStyle: TextStyle(
                    color: settingsProvider.lightMood()
                        ? Colors.black
                        : Colors.white),
                selectionColor: settingsProvider.lightMood()
                    ? Theme.of(context).accentColor
                    : Theme.of(context).accentColor,
                selectedTextColor: Theme.of(context).primaryColor,
                onDateChange: (date) {
                  if (date == null) {
                    return;
                  }
                  setState(() {
                    selectedDate = date;
                  });
                },
                locale: 'en ',
              ),
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
              stream: MyDatabase.getTasksRealTime(selectedDate),
              builder: (buildContext, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading tasks...\nTry Again later'),
                  );
                }
                var tasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return TaskItem(tasks![index]);
                  },
                  itemCount: tasks?.length ?? 0,
                );
              }),
        )
      ],
    );
  }
}
