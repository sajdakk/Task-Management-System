import '../state/to_do_state.dart';
import '../task.dart';
import 'task_factory.dart';

class ToDoTaskTypeFactory extends TaskFactory {
  @override
  Task createTask(String description) {
    return Task(
      description,
      state: ToDoState(),
    );
  }
}
