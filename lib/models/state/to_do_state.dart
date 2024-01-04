import '../../_project.dart';

class ToDoState implements TaskState {
  @override
  void changeTaskState(TaskInterface task, TaskState state) {
    if (state is DoneState) {
      throw Exception("Can't change to this state");
    }

    task.state = state;
  }

  @override
  String toString() {
    return "To Do";
  }

  @override
  get index => 1;
}
