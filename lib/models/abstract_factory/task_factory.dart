import '../../_project.dart';

abstract class TaskFactory {
  TaskInterface createTask(String description);
}
