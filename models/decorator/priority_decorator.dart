import '../priority/priority.dart';
import '../priority/priority_mapper.dart';
import '../task.dart';
import 'task_decorator.dart';

class PriorityDecorator extends TaskDecorator {
  late Priority priority;

  PriorityDecorator(
    Task task,
    this.priority,
  ) : super(task);

  @override
  String toString() {
    return super.toString() + "\n\t Priority: ${PriorityMapper.getName(priority)}";
  }
}
