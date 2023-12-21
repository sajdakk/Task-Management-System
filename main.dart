import 'dart:io';

import 'models/observer/task_observer.dart';
import 'models/state/done_state.dart';
import 'models/state/in_progress_state.dart';
import 'models/state/to_do_state.dart';
import 'models/task.dart';
import 'task_manager.dart';

void main() {
  var taskManager = TaskManager();
  var observer = TaskObserver('task_management');
  taskManager.addObserver(observer);

  while (true) {
    print("Choose an option:");
    print("1. Create Task");
    print("2. Display Tasks");
    print("3. Change Task Status");
    print("4. Exit");

    var choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        createTask(taskManager);
        break;
      case 2:
        taskManager.printTasks();
        break;
      case 3:
        changeTaskStatus(taskManager);
        break;
      case 4:
        exit(0);
      default:
        print("Invalid choice. Please choose again.");
    }
  }
}

void createTask(TaskManager taskManager) {
  print("Enter task description:");
  var description = stdin.readLineSync()!;
  var task = Task(description, state: ToDoState());
  taskManager.addTask(task);
  print("Task created successfully!");
}

void changeTaskStatus(TaskManager taskManager) {
  if (taskManager.tasks.isEmpty) {
    print("No tasks available. Create a task first.");
    return;
  }

  taskManager.printTasks();

  print("Enter the index of the task to change its status:");
  var index = int.parse(stdin.readLineSync()!);

  if (index >= 0 && index < taskManager.tasks.length) {
    var task = taskManager.tasks[index];
    print("Choose new status:");
    print("1. To Do");
    print("2. In Progress");
    print("3. Done");

    var statusChoice = int.parse(stdin.readLineSync()!);

    switch (statusChoice) {
      case 1:
        task.setState(ToDoState());
        break;
      case 2:
        task.setState(InProgressState());
        break;
      case 3:
        task.setState(DoneState());
        break;
      default:
        print("Invalid status choice.");
        return;
    }

    print("Task status updated successfully!");
  } else {
    print("Invalid index. Please choose a valid index.");
  }
}
