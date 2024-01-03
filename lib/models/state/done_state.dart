import '../../_project.dart';

class DoneState implements TaskState {
  @override
  void handleStatus(Task task) {}

  @override
  String toString() {
    return "Done";
  }

  @override
  get index => 3;
}
