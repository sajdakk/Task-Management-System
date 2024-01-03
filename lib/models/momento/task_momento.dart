import '../../_project.dart';

class TaskMemento {
  final String description;
  final List<TaskInterface> state;
  TaskMemento(
    this.description,
    this.state,
  );

  TaskMemento copy() {
    return TaskMemento(
      description,
      state.map((e) => e.copy()).toList(),
    );
  }
}
