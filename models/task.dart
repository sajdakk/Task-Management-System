import 'state/task_state.dart';

class Task {
  late String description;
  late TaskState state;

  Task(this.description, {required this.state});

  // Method to handle status changes using the current state
  void changeStatus() {
    state.handleStatus(this);
  }

  // Method to update the state of the task
  void setState(TaskState newState) {
    state = newState;
    changeStatus();
  }

  @override
  String toString() {
    return "Task: $description \n\t Status: $state";
  }
}
