// Decorator pattern
import '../task.dart';

abstract class TaskDecorator extends Task {
  TaskDecorator(Task task)
      : super(
          description: task.description,
          state: task.state,
        );

  String toString();
}
