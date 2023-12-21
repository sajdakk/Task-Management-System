import '../task.dart';
import 'task_observer_interface.dart';
import 'dart:io';

class TaskObserver implements TaskObserverInterface {
  TaskObserver(this.fileName);

  final String fileName;

  @override
  void update(List<Task> tasks) {
    var file = File(fileName);
    var tasksText = tasks.map((task) {
      return task.toString();
    }).join('\n');

    try {
      file.writeAsStringSync(tasksText);
      print("Tasks saved to file: $fileName");
    } catch (e) {
      print("Error saving tasks to file: $e");
    }
  }
}
