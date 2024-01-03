import '../../_project.dart';

class InProgressTaskTypeFactory extends TaskFactory {
  @override
  Task createTask(String description) {
    return Task(
      description: description,
      state: InProgressState(),
    );
  }
}
