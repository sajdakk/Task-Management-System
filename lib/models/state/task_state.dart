import '../../_project.dart';

abstract class TaskState {
  void handleStatus(Task task);

  @override
  String toString();

  int get index;
}
