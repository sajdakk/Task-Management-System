import '../../_project.dart';

class TaskSortContext {
  late TaskSortStrategy strategy;

  TaskSortContext(this.strategy);

  List<TaskInterface> executeStrategy(List<TaskInterface> tasks) {
    return strategy.sortTasks(tasks);
  }

  void setSortStrategy(TaskSortStrategy strategy) {
    this.strategy = strategy;
  }
}
