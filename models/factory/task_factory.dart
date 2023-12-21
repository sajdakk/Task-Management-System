// Factory pattern
import '../task.dart';

abstract class TaskFactory {
  Task createTask(String description);
}