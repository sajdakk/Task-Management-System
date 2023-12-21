// Strategy pattern
import '../task.dart';

abstract class TaskSortStrategy {
  List<Task> sortTasks(List<Task> tasks);
}
