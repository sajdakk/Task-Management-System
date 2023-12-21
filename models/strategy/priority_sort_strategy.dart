import '../decorator/priority_decorator.dart';
import '../priority/priority_mapper.dart';
import '../task.dart';
import 'task_sort_strategy.dart';

class PrioritySortStrategy extends TaskSortStrategy {
  @override
  List<Task> sortTasks(List<Task> tasks) {
    tasks.sort((a, b) {
      // Access the priority through the priorityDecorator if it exists
      var priorityA = (a is PriorityDecorator) ? (a).priority : null;
      var priorityB = (b is PriorityDecorator) ? (b).priority : null;

      if (priorityA != null && priorityB != null) {
        return -PriorityMapper.getIndex(priorityA).compareTo(PriorityMapper.getIndex(priorityB));
      } else if (priorityA != null) {
        return -1; // A has a priority, so it should come after B
      } else if (priorityB != null) {
        return 1; // B has a priority, so it should come before A
      } else {
        return 0; // Neither A nor B has a priority
      }
    });

    return tasks;
  }
}
