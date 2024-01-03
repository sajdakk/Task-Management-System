import '../../_project.dart';

class DeadlineDecorator extends TaskDecorator {
  DeadlineDecorator(
    TaskInterface task,
    this.deadline,
  )   : description = task.description,
        state = task.state,
        super(task);

  final DateTime deadline;

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
}
