import '../../_project.dart';

abstract class TaskDecorator extends Task {
  Task task;

  TaskDecorator(Task task)
      : task = task,
        super(
          description: task.description,
          state: task.state,
        );

  String toString();
}
