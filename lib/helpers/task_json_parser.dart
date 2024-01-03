import 'package:project/_project.dart';

class TaskJsonParser {
  static TaskInterface parse(Map<String,dynamic> json) {
    TaskInterface task = Task.fromJson(json);

    final List<TaskDecorator?> decorators = [
      DeadlineDecorator.fromJson(json),
      PriorityDecorator.fromJson(json),
    ];

    for (TaskDecorator? t in decorators) {
      if (t == null) {
        continue;
      }

      task = t.copyWith(task);
    }

    return task;
  }
}
