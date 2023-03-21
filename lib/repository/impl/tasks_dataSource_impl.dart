import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/repository/tasks_repository_contract.dart';

class TasksFireBaseDataSourceImpl extends TasksFireBaseDataSource {
  MyDatabase database;

  TasksFireBaseDataSourceImpl(this.database);

  @override
  Future<void> deleteTask(Task task) {
    return database.deleteTask(task);
  }

  @override
  Stream<QuerySnapshot<Task>> getTasksRealTime(DateTime dateTime) {
    return database.getTasksRealTime(dateTime);
  }

  @override
  Future<void> insertTask(Task task) {
    return database.insertTask(task);
  }

  @override
  Future<void> markAsDone(Task task) {
    return database.markAsDone(task);
  }

  @override
  Future<void> updateTask(
      Task task, String updateTittle, String updateDesc, DateTime newDate) {
    return database.updateTask(task, updateTittle, updateDesc, newDate);
  }
}
