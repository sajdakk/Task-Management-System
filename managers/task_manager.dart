import '../_project.dart';

class TaskManager {
  late List<Task> tasks;
  late TaskSortContext sortContext;
  late List<TaskObserverInterface> observers;
  late Stack<TaskMemento> undoStack;
  late Stack<TaskMemento> redoStack;

  TaskManager() {
    tasks = [];
    sortContext = TaskSortContext(PrioritySortStrategy());
    observers = [];
    undoStack = Stack<TaskMemento>();
    redoStack = Stack<TaskMemento>();
  }

  void addObserver(TaskObserverInterface observer) {
    observers.add(observer);
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

  void applyPriorityDecorator(Task task, Priority priority) {
    Task? updatedTask = tasks.firstWhereOrNull((element) => element == task);
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

  void applyDeadlineDecorator(Task task, DateTime deadline) {
    Task? updatedTask = tasks.firstWhereOrNull((element) => element == task);
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

  void changeTaskStatus(Task task, TaskState state) {
    Task? updatedTask = tasks.firstWhereOrNull((element) => element == task);
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

  void printTasks() {
    for (int i = 0; i < tasks.length; i++) {
      print("$i. " + tasks[i].toString());
    }
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
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      TaskMemento last = redoStack.pop();
      undoStack.push(last);

      tasks.clear();
      tasks.addAll(last.state.toList());
    } else {
      print("Nothing to redo.");
    }
  }
}
