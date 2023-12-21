import '../models/strategy/task_sort_context.dart';
import '../extensions/list_extensions.dart';
import '../models/decorator/deadline_decorator.dart';
import '../models/decorator/priority_decorator.dart';
import '../models/observer/task_observer_interface.dart';
import '../models/priority/priority.dart';
import '../models/state/task_state.dart';
import '../models/strategy/priority_sort_strategy.dart';
import '../models/strategy/task_sort_strategy.dart';
import '../models/task.dart';

class TaskManager {
  late List<Task> tasks;
  late TaskSortContext sortContext;
  late List<TaskObserverInterface> observers;

  TaskManager() {
    tasks = [];
    sortContext = TaskSortContext(PrioritySortStrategy());
    observers = [];
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
    sortTasks();

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
    sortTasks();
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
    sortTasks();

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
    sortTasks();

    notifyObservers();
  }

  void changeSortStrategy(TaskSortStrategy strategy) {
    sortContext.setSortStrategy(strategy);
    sortTasks();
    notifyObservers();
  }

  void sortTasks() {
    tasks = sortContext.executeStrategy(tasks);
  }

  void printTasks() {
    for (int i = 0; i < tasks.length; i++) {
      print("$i. " + tasks[i].toString());
    }
  }
}
