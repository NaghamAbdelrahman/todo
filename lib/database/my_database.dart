import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/task.dart';
import 'package:todo/utils/date_utils.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    var tasksCollection =
        FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
              fromFirestore: (snapshot, options) =>
                  Task.fromFireStore(snapshot.data()!),
              toFirestore: (task, options) => task.toFireStore(),
            );
    return tasksCollection;
  }

  static Future<void> insertTask(Task task) {
    var tasksCollection = getTasksCollection();
    var doc = tasksCollection.doc();
    task.id = doc.id;
    task.dateTime = MyDateUtils.extractDateOnly(task.dateTime);
    return doc.set(task);
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTime(DateTime dateTime) {
    return getTasksCollection()
        .where('datetime',
            isEqualTo:
                MyDateUtils.extractDateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.delete();
  }

  static Future<void> restoreTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.set(task);
  }

  static Future<void> markAsDone(Task task) {
    task.isDone = !task.isDone;
    return getTasksCollection().doc(task.id).set(task);
  }

  static Future<void> updateTask(
      Task task, String updateTittle, String updateDesc, DateTime newDate) {
    task.tittle = updateTittle;
    task.description = updateDesc;
    task.dateTime = MyDateUtils.extractDateOnly(newDate);
    return getTasksCollection().doc(task.id).set(task);
  }
}
