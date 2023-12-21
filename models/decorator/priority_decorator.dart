import '../task.dart';
import 'task_decorator.dart';

class PriorityDecorator extends TaskDecorator {
  PriorityDecorator(Task task) : super(task);

  @override
  String toString() {
    return super.toString() + "\n\t Priority: high";
  }
}
