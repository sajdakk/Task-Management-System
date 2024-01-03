import '../../_project.dart';

class Task implements TaskInterface {
  @override
  late String description;
  @override
  late TaskState state;

  Task({
    required this.state,
    required this.description,
  });

  // Method to handle status changes using the current state
  @override
  void changeStatus() {
    state.handleStatus(this);
  }

  // Method to update the state of the task
  @override
  void setState(TaskState newState) {
    state = newState;
    changeStatus();
  }

  @override
  Task copy() => Task(
        state: state,
        description: description,
      );

  @override
  String toString() {
    return "Task: $description \n\t Status: $state";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "state": state.index,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    TaskState? state = TaskStateFactory().build(json["state"]);
    String description = json["description"];
    if (state == null) {
      throw Exception("Invalid state");
    }

    return Task(
      state: state,
      description: description,
    );
  }
}
