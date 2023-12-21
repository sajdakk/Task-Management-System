// State pattern for task status
import '../models/state/task_state.dart';
import '../models/task.dart';

class TaskStateContext {
  late TaskState _taskState;

  void setTaskState(TaskState taskState) {
    _taskState = taskState;
  }

  void handleTaskStatus(Task task) {
    _taskState.handleStatus(task);
  }
}
