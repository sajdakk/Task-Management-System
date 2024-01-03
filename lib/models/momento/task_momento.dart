import '../../_project.dart';

class TaskMemento {
  final String description;
  final List<TaskInterface> state;
  TaskMemento(this.description, this.state);
}
