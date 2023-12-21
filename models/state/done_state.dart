import '../task.dart';
import 'task_state.dart';

class DoneState implements TaskState {
  @override
  void handleStatus(Task task) {
    print("Task is done");
  }

  @override
  String toString() {
    return "Done";
  }
}
