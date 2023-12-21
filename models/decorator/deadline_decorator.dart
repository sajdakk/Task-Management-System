import '../task.dart';
import 'task_decorator.dart';

class DeadlineDecorator extends TaskDecorator {
  late DateTime deadline;

  DeadlineDecorator(Task task, this.deadline) : super(task);

  @override
  String toString() {
    return super.toString() + "\n\t Deadline: ${deadline.toLocal()}";
  }
}
