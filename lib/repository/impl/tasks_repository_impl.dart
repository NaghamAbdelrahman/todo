import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/task.dart';
import 'package:todo/repository/tasks_repository_contract.dart';

class TasksRepositoryImpl extends TasksRepository {
  TasksFireBaseDataSource dataSource;

  TasksRepositoryImpl(this.dataSource);

  @override
  Future<void> deleteTask(Task task) {
    return dataSource.deleteTask(task);
  }

  @override
  Stream<QuerySnapshot<Task>> getTasksRealTime(DateTime dateTime) {
    return dataSource.getTasksRealTime(dateTime);
  }

  @override
  Future<void> insertTask(Task task) {
    return dataSource.insertTask(task);
  }

  @override
  Future<void> markAsDone(Task task) {
    return dataSource.markAsDone(task);
  }

  @override
  Future<void> updateTask(
      Task task, String updateTittle, String updateDesc, DateTime newDate) {
    return dataSource.updateTask(task, updateTittle, updateDesc, newDate);
  }
}
