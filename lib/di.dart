import 'package:todo/database/my_database.dart';
import 'package:todo/repository/impl/tasks_dataSource_impl.dart';
import 'package:todo/repository/impl/tasks_repository_impl.dart';
import 'package:todo/repository/tasks_repository_contract.dart';

MyDatabase getDataBase() {
  return MyDatabase();
}

TasksFireBaseDataSource injectTasksDataSource() {
  return TasksFireBaseDataSourceImpl(getDataBase());
}

TasksRepository injectTasksRepository() {
  return TasksRepositoryImpl(injectTasksDataSource());
}
