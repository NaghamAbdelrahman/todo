import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/ui/home/add_task.dart';
import 'package:todo/ui/home/settings/settings_tab.dart';
import 'package:todo/ui/home/tasks_list/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: selectedIndex == 0
            ? Text(AppLocalizations.of(context)!.toDoList)
            : Text(AppLocalizations.of(context)!.settings),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).accentColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (newlySelectedIndex) {
            setState(() {
              selectedIndex = newlySelectedIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showAddTaskBottomSheet();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  var tabs = [const TasksTab(), SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return const AddTask();
        });
  }
}
