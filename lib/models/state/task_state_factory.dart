import 'package:project/_project.dart';

class TaskStateFactory {
  TaskState? build(int index) {
    switch (index) {
      case 1:
        return ToDoState();
      case 2:
        return InProgressState();
      case 3:
        return DoneState();
      default:
        return null;
    }
  }
}
