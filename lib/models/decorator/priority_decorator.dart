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
    return task.toString() + "\n\t Priority: ${PriorityMapper.getName(priority)}";
  }
}
