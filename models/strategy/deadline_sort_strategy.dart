import '../../_project.dart';

class DeadlineSortStrategy implements TaskSortStrategy {
  @override
  List<Task> sortTasks(List<Task> tasks) {
    tasks.sort((a, b) {
      // Access the deadline through the DeadlineDecorator if it exists
      var deadlineA = (a is DeadlineDecorator) ? (a).deadline : null;
      var deadlineB = (b is DeadlineDecorator) ? (b).deadline : null;

      if (deadlineA != null && deadlineB != null) {
        return -deadlineA.compareTo(deadlineB);
      } else if (deadlineA != null) {
        return -1; // A has a deadline, so it should come after B
      } else if (deadlineB != null) {
        return 1; // B has a deadline, so it should come before A
      } else {
        return 0; // Neither A nor B has a deadline
      }
    });

    return tasks;
  }
}
