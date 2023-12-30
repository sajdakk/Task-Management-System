import '../state/in_progress_state.dart';
import '../task.dart';
import 'task_factory.dart';

class InProgressTaskTypeFactory extends TaskFactory {
  @override
  Task createTask(String description) {
    return Task(
      description: description,
      state: InProgressState(),
    );
  }
}
