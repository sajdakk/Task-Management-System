import '../../_project.dart';

class DeadlineDecorator extends TaskDecorator {
  DeadlineDecorator(
    TaskInterface task,
    this.deadline,
  )   : description = task.description,
        state = task.state,
        super(task);

  DateTime deadline;

  @override
  String description;

  @override
  TaskState state;

  @override
  TaskInterface copy() => DeadlineDecorator(
        super.task,
        deadline,
      );

  @override
  String toString() {
    DateTime local = deadline.toLocal();
    return "$task\n\t Deadline: ${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...task.toJson(),
      "deadline": deadline.toIso8601String(),
    };
  }

  static DeadlineDecorator? fromJson(Map<String, dynamic> json) {
    final String? deadlineRaw = json["deadline"];
    if (deadlineRaw == null) {
      return null;
    }

    Task task = Task.fromJson(json);
    DateTime? deadline = DateTime.tryParse(deadlineRaw);

    if (deadline == null) {
      throw Exception("Invalid deadline");
    }

    return DeadlineDecorator(
      task,
      deadline,
    );
  }

  @override
  TaskDecorator copyWith(TaskInterface task) {
    return DeadlineDecorator(
      task,
      deadline,
    );
  }
}
