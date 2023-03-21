import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/di.dart';
import 'package:todo/ui/base/base_state.dart';
import 'package:todo/ui/edit_task/edit_task_screen.dart';
import 'package:todo/ui/home/home_viewModel.dart';
import 'package:todo/ui/my_theme.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends BaseState<TaskItem, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel(injectTasksRepository());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditTaskScreen.routeName,
            arguments: widget.task);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.red),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                onPressed: (buildContext) {
                  deleteTak();
                },
                backgroundColor: Colors.red,
                label: AppLocalizations.of(context)!.delete,
                icon: Icons.delete,
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).accentColor),
            child: Row(
              children: [
                Container(
                  height: 85,
                  width: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.task.isDone == false
                          ? Theme.of(context).primaryColor
                          : MyTheme.green),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.task.tittle,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: widget.task.isDone == false
                              ? Theme.of(context).primaryColor
                              : MyTheme.green),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(widget.task.description,
                        style: Theme.of(context).textTheme.subtitle1),
                  ],
                )),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () async {
                    await viewModel.markAsDone(widget.task);
                    setState(() {});
                  },
                  child: widget.task.isDone == false
                      ? Container(
                    padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).primaryColor),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                    AppLocalizations.of(context)!.isDone,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: MyTheme.green),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTak() {
    viewModel.deleteTak(widget.task);
  }
}
