import '../task.dart';
import 'task_state.dart';

class ToDoState implements TaskState {
  @override
  void handleStatus(Task task) {
    print("Task is to do");
  }

  @override
  String toString() {
    return "To Do";
  }
}
