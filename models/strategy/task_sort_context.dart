import '../../_project.dart';

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
