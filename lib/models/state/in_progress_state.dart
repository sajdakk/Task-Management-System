import '../../_project.dart';

class InProgressState implements TaskState {
  @override
  void handleStatus(Task task) {
  }

  @override
  String toString() {
    return "In Progress";
  }

  @override
  get index => 2;
}
