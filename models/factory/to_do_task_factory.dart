import '../../_project.dart';

class ToDoTaskTypeFactory extends TaskFactory {
  @override
  Task createTask(String description) {
    return Task(
      description: description,
      state: ToDoState(),
    );
  }
}
