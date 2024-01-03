import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:project/helpers/task_json_parser.dart';

import '../_project.dart';

class TaskManager {
  late List<TaskInterface> tasks;
  late TaskSortContext sortContext;
  late List<TaskObserverInterface> observers;
  late Stack<TaskMemento> undoStack;
  late Stack<TaskMemento> redoStack;
  List<TaskInterface> _initialState = [];

  static TaskManager? _instance;

  TaskManager._internal() {
    tasks = [];

    sortContext = TaskSortContext(PrioritySortStrategy());
    observers = [];
    undoStack = Stack<TaskMemento>();
    redoStack = Stack<TaskMemento>();
  }

  Future<void> init(String fileName) async {
    final Directory downloadsDir = await getApplicationDocumentsDirectory();
    final File file = File(path.join(downloadsDir.path, fileName));
    if (file.existsSync()) {
      final String fileContent = file.readAsStringSync();
      final List<dynamic> parsed = jsonDecode(fileContent);
      tasks = parsed
          .map(
            (e) => TaskJsonParser.parse(e),
          )
          .toList();

      _initialState = tasks.toList();
    }

    _sortTasks();

    notifyObservers();
    undoStack = Stack<TaskMemento>();
    redoStack = Stack<TaskMemento>();
  }

  factory TaskManager() {
    _instance ??= TaskManager._internal();

    return _instance!;
  }

  void addObserver(TaskObserverInterface observer) {
    observers.add(observer);
  }

  void removeObserver(TaskObserverInterface observer) {
    observers.remove(observer);
  }

  void notifyObservers() {
    for (var observer in observers) {
      observer.update(tasks);
    }
  }

  void addTask(Task task) {
    tasks.add(task);
    _sortTasks();
    _saveTasksState();

    notifyObservers();
  }

  void removeTask(TaskInterface task) {
    tasks.remove(task);
    _sortTasks();
    _saveTasksState();

    notifyObservers();
  }

  void applyPriorityDecorator(TaskInterface task, Priority priority) {
    TaskInterface? updatedTask = tasks.firstWhereOrNull((element) => element == task);
    if (updatedTask == null) {
      return;
    }

    updatedTask = PriorityDecorator(task, priority);
    tasks.remove(task);
    tasks.add(updatedTask);
    _sortTasks();
    _saveTasksState();
    notifyObservers();
  }

  void changePriorityDecorator(TaskInterface task, Priority priority) {
    if (task is! PriorityDecorator) {
      return;
    }

    TaskInterface? updatedTask = tasks.firstWhereOrNull((element) => element == task);
    if (updatedTask == null) {
      return;
    }

    if (updatedTask is! PriorityDecorator) {
      return;
    }

    updatedTask.priority = priority;
    tasks.remove(task);
    tasks.add(updatedTask);
    _sortTasks();
    _saveTasksState();
    notifyObservers();
  }

  void applyDeadlineDecorator(TaskInterface task, DateTime deadline) {
    TaskInterface? updatedTask = tasks.firstWhereOrNull((element) => element == task);
    if (updatedTask == null) {
      return;
    }

    updatedTask = DeadlineDecorator(task, deadline);
    tasks.remove(task);
    tasks.add(updatedTask);
    _sortTasks();
    _saveTasksState();

    notifyObservers();
  }

  void changeDeadlineDecorator(TaskInterface task, DateTime deadline) {
    if (task is! DeadlineDecorator) {
      return;
    }

    TaskInterface? updatedTask = tasks.firstWhereOrNull((element) => element == task);
    if (updatedTask == null) {
      return;
    }

    if (updatedTask is! DeadlineDecorator) {
      return;
    }

    updatedTask.deadline = deadline;
    tasks.remove(task);
    tasks.add(updatedTask);
    _sortTasks();
    _saveTasksState();

    notifyObservers();
  }

  void changeTaskStatus(TaskInterface task, TaskState state) {
    TaskInterface? updatedTask = tasks.firstWhereOrNull((element) => element == task);
    if (updatedTask == null) {
      return;
    }

    updatedTask.setState(state);
    tasks.remove(task);
    tasks.add(updatedTask);
    _sortTasks();
    _saveTasksState();

    notifyObservers();
  }

  void changeSortStrategy(TaskSortStrategy strategy) {
    sortContext.setSortStrategy(strategy);
    _sortTasks();
    _saveTasksState();
    notifyObservers();
  }

  void _sortTasks() {
    tasks = sortContext.executeStrategy(tasks);
  }

  String printTasks() {
    String result = "";
    for (int i = 0; i < tasks.length; i++) {
      result += "\n\n$i. ${tasks[i]}";
    }

    return result;
  }

  void _saveTasksState() {
    var currentSnapshot = TaskMemento("Snapshot", tasks.map((e) => e.copy()).toList());

    undoStack.push(currentSnapshot);

    redoStack.clear(); // Clear redo stack when a new state is saved
  }

  void undo() {
    if (undoStack.isNotEmpty) {
      TaskMemento last = undoStack.pop();
      redoStack.push(last);

      if (undoStack.isEmpty) {
        tasks = _initialState.toList();
        notifyObservers();

        return;
      }

      tasks.clear();
      tasks.addAll(undoStack.peek().state.toList());
    } else {
      TmMessage.showInfo("Nothing to undo");
    }

    notifyObservers();
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      TaskMemento last = redoStack.pop();
      undoStack.push(last);

      tasks.clear();
      tasks.addAll(last.state.toList());
      notifyObservers();
    } else {
      TmMessage.showInfo("Nothing to redo");
    }
  }
}
