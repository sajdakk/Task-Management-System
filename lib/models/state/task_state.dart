import '../../_project.dart';

abstract class TaskState {
  void changeTaskState(TaskInterface task, TaskState state);

  @override
  String toString();

  int get index;
}
