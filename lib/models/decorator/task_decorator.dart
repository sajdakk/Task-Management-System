import '../../_project.dart';

abstract class TaskDecorator implements TaskInterface {
  TaskInterface task;

  TaskDecorator(this.task) : super();

  @override
  String toString();

  @override
  void changeStatus() {
    task.changeStatus();
  }

  @override
  void setState(TaskState newState) {
    task.setState(newState);
  }

  @override
  TaskInterface copy() {
    return task.copy();
  }
}
