import '../../_project.dart';

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
