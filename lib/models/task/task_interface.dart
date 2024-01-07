import '../../_project.dart';

abstract class TaskInterface {
  late String description;
  late TaskState state;
  late DateTime? deadline;
  late Priority? priority;

  // Method to update the state of the task
  void setState(TaskState newState);

  TaskInterface clone();

  @override
  String toString();

  Map<String, dynamic> toJson();
}
