import '../../_project.dart';

class DoneState implements TaskState {
  @override
  void handleStatus(Task task) {
    print("Task is done");
  }

  @override
  String toString() {
    return "Done";
  }

  @override
  get index => 3;
}
