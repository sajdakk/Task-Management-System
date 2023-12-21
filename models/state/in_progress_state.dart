import '../task.dart';
import 'task_state.dart';

class InProgressState implements TaskState {
  @override
  void handleStatus(Task task) {
   print("Task is in progress");
  }

  @override
  String toString() {
    return "In Progress";
  }
}
