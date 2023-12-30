import '../../_project.dart';

class Task implements TaskInterface {
  late String description;
  late TaskState state;

  Task({
    required this.state,
    required this.description,
  });

  // Method to handle status changes using the current state
  void changeStatus() {
    state.handleStatus(this);
  }

  // Method to update the state of the task
  void setState(TaskState newState) {
    state = newState;
    changeStatus();
  }

  Task copy() => Task(
        state: state,
        description: description,
      );

  @override
  String toString() {
    return "Task: $description \n\t Status: $state";
  }
}
