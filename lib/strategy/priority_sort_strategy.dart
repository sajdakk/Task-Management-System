import '../_project.dart';

class PrioritySortStrategy extends TaskSortStrategy {
  @override
  List<TaskInterface> sortTasks(List<TaskInterface> tasks) {
    tasks.sort((a, b) {
      if (a.priority != null && b.priority != null) {
        // Compare the two tasks by their state and priority
        final int priorityAIndex = PriorityMapper.getIndex(a.priority!);
        final int priorityBIndex = PriorityMapper.getIndex(b.priority!);

        if (priorityAIndex == priorityBIndex) {
          final int stateAIndex = a.state.index;
          final int stateBIndex = b.state.index;

          return stateAIndex.compareTo(stateBIndex);
        }

        return -priorityAIndex.compareTo(priorityBIndex);
      }

      if (a.priority == null && b.priority == null) {
        // Compare the two tasks by their state
        final int stateAIndex = a.state.index;
        final int stateBIndex = b.state.index;

        return stateAIndex.compareTo(stateBIndex);
      }

      if (a.priority != null) {
        return -1;
      }

      if (b.priority != null) {
        return 1;
      }

      return 0;
    });

    return tasks;
  }

  @override
  String get name => "Priority";
}
