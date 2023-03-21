import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/task.dart';

abstract class TasksFireBaseDataSource {
  Future<void> insertTask(Task task);

  Future<void> deleteTask(Task task);

  Stream<QuerySnapshot<Task>> getTasksRealTime(DateTime dateTime);

  Future<void> markAsDone(Task task);

  Future<void> updateTask(
      Task task, String updateTittle, String updateDesc, DateTime newDate);
}

abstract class TasksRepository {
  Future<void> insertTask(Task task);

  Future<void> deleteTask(Task task);

  Stream<QuerySnapshot<Task>> getTasksRealTime(DateTime dateTime);

  Future<void> markAsDone(Task task);

  Future<void> updateTask(
      Task task, String updateTittle, String updateDesc, DateTime newDate);
}
