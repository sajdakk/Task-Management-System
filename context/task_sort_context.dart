// Strategy pattern for task sorting
import '../models/strategy/task_sort_strategy.dart';
import '../models/task.dart';

class TaskSortContext {
  late TaskSortStrategy strategy;

  TaskSortContext(this.strategy);

  List<Task> executeStrategy(List<Task> tasks) {
    return strategy.sortTasks(tasks);
  }

  void setSortStrategy(TaskSortStrategy strategy) {
    this.strategy = strategy;
  }
}
