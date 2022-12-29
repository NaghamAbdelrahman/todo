import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/ui/my_theme.dart';
import 'package:todo/utils/dialog_utils.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.red),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              onPressed: (buildContext) {
                deleteTak();
              },
              backgroundColor: Colors.red,
              label: 'Delete',
              icon: Icons.delete,
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
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
              SizedBox(
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
                  SizedBox(
                    height: 12,
                  ),
                  Text(widget.task.description),
                ],
              )),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  MyDatabase.markAsDone(widget.task);
                  setState(() {});
                },
                child: widget.task.isDone == false
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).primaryColor),
                      )
                    : Text(
                        'Done !',
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
    );
  }

  void deleteTak() {
    DialogUtils.showMessageDialog(
      context,
      'Are you sure. you want to delete this task ?',
      posActionTittle: 'Yes',
      posAction: () async {
        //     DialogUtils.showProgressDialog(context, 'Loading...');
        await MyDatabase.deleteTask(widget.task);
        //   DialogUtils.hideDialog(context);
        // DialogUtils.showMessageDialog(context, 'Task deleted successfully',
        //   posActionTittle: 'Ok', negActionTittle: 'Undo', negAction: () {});
      },
      negActionTittle: 'Cancel',
    );
  }
}
