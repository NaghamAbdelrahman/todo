import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/repository/tasks_repository_contract.dart';
import 'package:todo/ui/base/base_viewModel.dart';
import '../../database/task.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  TasksRepository repository;

  HomeViewModel(this.repository);

  void saveTask(
      String tittle, String description, DateTime selectedDate) async {
    navigator?.showProgressDialog('Loading...', isDismisable: false);
    try {
      await repository.insertTask(Task(
          tittle: tittle, description: description, dateTime: selectedDate));
      navigator?.hideDialog();
      navigator?.showMessageDialog('Task inserted successfully',
          posActionTittle: 'ok', posAction: () {
        navigator?.hideDialog();
      }, isDismisable: false);
    } catch (e) {
      navigator?.hideDialog();
      navigator?.showMessageDialog('error ', posAction: () {
        saveTask(tittle, description, selectedDate);
      }, posActionTittle: 'Try again', negActionTittle: 'cancel');
    }
  }

  Stream<QuerySnapshot<Task>> getTask(DateTime selectedDate) {
    return repository.getTasksRealTime(selectedDate);
  }

  void deleteTak(Task task) {
    navigator?.showMessageDialog('Are you sure. you want to delete this task ?',
        posActionTittle: 'yes', posAction: () {
      repository.deleteTask(task);
    }, negActionTittle: 'cancel');
  }

  Future<void> markAsDone(Task task) {
    return repository.markAsDone(task);
  }
}

abstract class HomeNavigator extends BaseNavigator {}
