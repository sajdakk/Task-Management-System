import '../../_project.dart';

class PriorityDecorator extends TaskDecorator {
  PriorityDecorator(
    TaskInterface task,
    this.priority,
  )   : description = task.description,
        state = task.state,
        super(task);

  Priority priority;
  @override
  String description;
  @override
  TaskState state;

  @override
  TaskInterface copy() => PriorityDecorator(
        super.task,
        priority,
      );

  String get priorityName => PriorityMapper.getName(priority);

  @override
  void changeStatus() {
    task.changeStatus();
  }

  @override
  void setState(TaskState newState) {
    task.setState(newState);
  }

  @override
  String toString() {
    return "$task\n\t Priority: ${PriorityMapper.getName(priority)}";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...task.toJson(),
      "priority": PriorityMapper.getName(priority),
    };
  }

  static PriorityDecorator? fromJson(Map<String, dynamic> json) {
    final String? priorityRaw = json["priority"];
    if (priorityRaw == null) {
      return null;
    }

    Priority? priority = PriorityMapper.getPriority(priorityRaw);

    if (priority == null) {
      throw Exception("Invalid priority");
    }

    Task task = Task.fromJson(json);

    return PriorityDecorator(
      task,
      priority,
    );
  }

  @override
  TaskDecorator copyWith(TaskInterface task) {
    return PriorityDecorator(
      task,
      priority,
    );
  }
}
