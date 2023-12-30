import '../../_project.dart';

class DeadlineDecorator extends TaskDecorator {
  late DateTime deadline;

  DeadlineDecorator(Task task, this.deadline) : super(task);

  @override
  Task copy() => DeadlineDecorator(
        super.task,
        deadline,
      );

  @override
  String toString() {
    return super.toString() + "\n\t Deadline: ${deadline.toLocal()}";
  }
}
