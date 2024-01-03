import '../_project.dart';

class TaskManager {
  late List<TaskInterface> tasks;
  late TaskSortContext sortContext;
  late List<TaskObserverInterface> observers;
  late Stack<TaskMemento> undoStack;
  late Stack<TaskMemento> redoStack;

  static TaskManager? _instance;

  TaskManager._internal() {
    tasks = [];
    sortContext = TaskSortContext(PrioritySortStrategy());
    observers = [];
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
        tasks.clear();

        return;
      }

      tasks.clear();
      tasks.addAll(undoStack.peek().state.toList());
    } else {
      tasks.clear();
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
