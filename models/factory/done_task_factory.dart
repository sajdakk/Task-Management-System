import '../../_project.dart';

class DoneTaskTypeFactory extends TaskFactory {
  @override
  Task createTask(String description) {
    return Task(
      description: description,
      state: DoneState(),
    );
  }
}
