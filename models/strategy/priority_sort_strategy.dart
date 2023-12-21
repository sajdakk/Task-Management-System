import '../task.dart';
import 'task_sort_strategy.dart';

class PrioritySortStrategy extends TaskSortStrategy {
  @override
  List<Task> sortTasks(List<Task> tasks) {
    tasks.sort((a, b) => a.description.compareTo(b.description));
    return tasks;
  }
}
