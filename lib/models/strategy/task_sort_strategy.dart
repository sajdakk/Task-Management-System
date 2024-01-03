import '../../_project.dart';

abstract class TaskSortStrategy {
  List<TaskInterface> sortTasks(List<TaskInterface> tasks);

  String get name;
}
