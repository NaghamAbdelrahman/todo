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

  static markAsDone(Task task) {
    task.isDone = true;
    getTasksCollection().doc(task.id).set(task);
  }
}
