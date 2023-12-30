import 'dart:io';

import '_project.dart';

void main() {
  var taskManager = TaskManager();
  var observer = TaskObserver('task_management');
  taskManager.addObserver(observer);

  while (true) {
    print("Choose an option:");
    print("1. Create Task");
    print("2. Display Tasks");
    print("3. Change Task Status");
    print("4. Change Sort Type");
    print("5. Change Task Priority");
    print("6. Add Deadline to Task");
    print("7. Undo");
    print("8. Redo");
    print("9. Exit");

    var choice = int.tryParse(stdin.readLineSync()!);

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
        changeSortType(taskManager);
        break;
      case 5:
        changeTaskPriority(taskManager);
        break;
      case 6:
        addDeadlineToTask(taskManager);
        break;
      case 7:
        taskManager.undo();
        break;
      case 8:
        taskManager.redo();
        break;
      case 9:
        exit(0);
      default:
        print("Invalid choice. Please choose again.");
    }
  }
}

void createTask(TaskManager taskManager) {
  print("Enter task description:");
  var description = stdin.readLineSync()!;
  var task = Task(
    description: description,
    state: ToDoState(),
  );
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
        taskManager.changeTaskStatus(task, ToDoState());
        break;
      case 2:
        taskManager.changeTaskStatus(task, InProgressState());
        break;
      case 3:
        taskManager.changeTaskStatus(task, DoneState());
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

void changeSortType(TaskManager taskManager) {
  print("Choose a sort type:");
  print("1. Priority Sort");
  print("2. Deadline Sort");

  var choice = int.parse(stdin.readLineSync()!);

  switch (choice) {
    case 1:
      taskManager.changeSortStrategy(PrioritySortStrategy());
      print("Sort type changed to Priority Sort");
      break;
    case 2:
      taskManager.changeSortStrategy(DeadlineSortStrategy());
      print("Sort type changed to Deadline Sort");
      break;
    default:
      print("Invalid sort type choice.");
  }
}

void changeTaskPriority(TaskManager taskManager) {
  if (taskManager.tasks.isEmpty) {
    print("No tasks available. Create a task first.");
    return;
  }

  taskManager.printTasks();

  print("Enter the index of the task to change its priority:");
  var index = int.parse(stdin.readLineSync()!);

  if (index >= 0 && index < taskManager.tasks.length) {
    var task = taskManager.tasks[index];
    print("Choose new priority:");
    print("1. Low");
    print("2. Medium");
    print("3. High");

    var priorityChoice = int.parse(stdin.readLineSync()!);

    switch (priorityChoice) {
      case 1:
        taskManager.applyPriorityDecorator(task, Priority.low);
        break;
      case 2:
        taskManager.applyPriorityDecorator(task, Priority.medium);
        break;
      case 3:
        taskManager.applyPriorityDecorator(task, Priority.high);
        break;
      default:
        print("Invalid priority choice.");
        return;
    }

    print("Task priority updated successfully!");
  } else {
    print("Invalid index. Please choose a valid index.");
  }
}

void addDeadlineToTask(TaskManager taskManager) {
  if (taskManager.tasks.isEmpty) {
    print("No tasks available. Create a task first.");
    return;
  }

  taskManager.printTasks();

  print("Enter the index of the task to add a deadline:");
  var index = int.parse(stdin.readLineSync()!);

  if (index >= 0 && index < taskManager.tasks.length) {
    var task = taskManager.tasks[index];
    print("Enter the deadline (yyyy-mm-dd):");
    var deadlineString = stdin.readLineSync()!;
    DateTime? deadline = DateTime.tryParse(deadlineString);
    if (deadline == null) {
      print("Invalid date format. Please enter a valid date.");
      return;
    }

    taskManager.applyDeadlineDecorator(task, deadline);
    print("Deadline added to the task successfully!");
  } else {
    print("Invalid index. Please choose a valid index.");
  }
}
