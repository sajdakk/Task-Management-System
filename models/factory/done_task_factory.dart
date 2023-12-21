import '../state/done_state.dart';
import '../task.dart';
import 'task_factory.dart';

class DoneTaskTypeFactory extends TaskFactory {
  @override
  Task createTask(String description) {
    return Task(
      description,
      state: DoneState(),
    );
  }
}
