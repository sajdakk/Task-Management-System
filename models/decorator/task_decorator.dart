// Decorator pattern
import '../task.dart';

abstract class TaskDecorator extends Task {
  TaskDecorator(Task task)
      : super(
          task.description,
          state: task.state,
        );

  String toString();
}
