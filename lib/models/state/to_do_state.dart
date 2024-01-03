import '../../_project.dart';

class ToDoState implements TaskState {
  @override
  void handleStatus(Task task) {
  }

  @override
  String toString() {
    return "To Do";
  }

  @override
  get index => 1;
}
