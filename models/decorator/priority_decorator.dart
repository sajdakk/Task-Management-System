import '../../_project.dart';

class PriorityDecorator extends TaskDecorator {
  late Priority priority;

  PriorityDecorator(
    Task task,
    this.priority,
  ) : super(task);

  @override
  Task copy() => PriorityDecorator(
        super.task,
        priority,
      );

  @override
  String toString() {
    return super.toString() + "\n\t Priority: ${PriorityMapper.getName(priority)}";
  }
}
