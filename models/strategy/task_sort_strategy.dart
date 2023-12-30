import '../../_project.dart';

abstract class TaskSortStrategy {
  List<Task> sortTasks(List<Task> tasks);
}
