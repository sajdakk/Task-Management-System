// Observer pattern
import '../task.dart';

abstract class TaskObserverInterface {
  void update(List<Task> tasks);
}
