import 'package:todo/repository/tasks_repository_contract.dart';
import 'package:todo/ui/base/base_viewModel.dart';

import '../../database/my_database.dart';
import '../../database/task.dart';

class EditTaskViewModel extends BaseViewModel<EditTaskNavigator> {
  TasksRepository repository;

  EditTaskViewModel(this.repository);

  void updateTask(Task task, String tittle, String description,
      DateTime selectedDate) async {
    await repository.updateTask(task, tittle, description, selectedDate);
    navigator?.closePage();
  }
}

abstract class EditTaskNavigator extends BaseNavigator {
  closePage();
}
