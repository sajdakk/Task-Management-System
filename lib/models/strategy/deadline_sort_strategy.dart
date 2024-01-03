import '../../_project.dart';

class DeadlineSortStrategy implements TaskSortStrategy {
  @override
  List<TaskInterface> sortTasks(List<TaskInterface> tasks) {
    tasks.sort((a, b) {
      if (a is DeadlineDecorator && b is DeadlineDecorator) {
        // Compare the two tasks by their state and priority
        DateTime deadlineA = a.deadline;
        DateTime deadlineB = b.deadline;

        if (deadlineA == deadlineB) {
          final int stateAIndex = a.state.index;
          final int stateBIndex = b.state.index;

          return stateAIndex.compareTo(stateBIndex);
        }

        return deadlineA.compareTo(deadlineB);
      }

      if (a is! DeadlineDecorator && b is! DeadlineDecorator) {
        // Compare the two tasks by their state
        final int stateAIndex = a.state.index;
        final int stateBIndex = b.state.index;

        return stateAIndex.compareTo(stateBIndex);
      }

      if (a is DeadlineDecorator) {
        return -1;
      }

      if (b is DeadlineDecorator) {
        return 1;
      }

      return 0;
    });

    return tasks;
  }

  @override
  String get name => "Deadline";
}
