// State pattern for task status
import '../task.dart';

abstract class TaskState {
  void handleStatus(Task task);

  @override
  String toString();
}
