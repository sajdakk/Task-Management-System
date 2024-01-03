import '../../_project.dart';

abstract class TaskInterface {
  late String description;
  late TaskState state;
  late DateTime? deadline;
  late Priority? priority;

  // Method to handle status changes using the current state
  void changeStatus();

  // Method to update the state of the task
  void setState(TaskState newState);

  TaskInterface copy();

  @override
  String toString();

  Map<String, dynamic> toJson();
}
