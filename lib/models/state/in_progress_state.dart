import '../../_project.dart';

class InProgressState implements TaskState {
  @override
  void changeTaskState(TaskInterface task, TaskState state) {
    task.state = state;
  }

  @override
  String toString() {
    return "In Progress";
  }

  @override
  get index => 2;
}
