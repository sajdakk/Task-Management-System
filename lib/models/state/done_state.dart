import '../../_project.dart';

class DoneState implements TaskState {
  @override
  void changeTaskState(TaskInterface task, TaskState state) {
    // throw Exception("Can't change to this state");
    task.state = state;
  }

  @override
  String toString() {
    return "Done";
  }

  @override
  get index => 3;
}
