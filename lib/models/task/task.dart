import '../../_project.dart';

class Task implements TaskInterface {
  @override
  late String description;
  @override
  late TaskState state;

  @override
  late DateTime? deadline;

  @override
  late Priority? priority;

  Task({
    required this.state,
    required this.description,
    this.deadline,
    this.priority,
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
        deadline: deadline,
        priority: priority,
      );

  @override
  String toString() {
    DateTime? date = deadline?.toLocal();
    String? deadlinePart = date == null
        ? ""
        : "\n\t Deadline: ${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    String? priorityPart = priority == null ? "" : "\n\t Priority: ${PriorityMapper.getName(priority!)}";

    return "Task: $description \n\t Status: $state $deadlinePart $priorityPart";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "state": state.index,
      if (deadline != null) "deadline": deadline!.toIso8601String(),
      if (priority != null) "priority": priority!.index,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    TaskState? state = TaskStateFactory().build(json["state"]);
    String description = json["description"];
    if (state == null) {
      throw Exception("Invalid state");
    }

    final String? deadlineRaw = json["deadline"];
    final String? priorityRaw = json["priority"];

    Priority? priority = priorityRaw == null ? null : PriorityMapper.getPriority(priorityRaw);
    DateTime? deadline = deadlineRaw == null ? null : DateTime.tryParse(deadlineRaw);

    return Task(
      state: state,
      description: description,
      deadline: deadline,
      priority: priority,
    );
  }
}
