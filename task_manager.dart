import 'context/task_sort_context.dart';
import 'context/task_state_context.dart';
import 'extensions/list_extensions.dart';
import 'models/decorator/deadline_decorator.dart';
import 'models/decorator/priority_decorator.dart';
import 'models/observer/task_observer_interface.dart';
import 'models/state/task_state.dart';
import 'models/strategy/priority_sort_strategy.dart';
import 'models/strategy/task_sort_strategy.dart';
import 'models/task.dart';

class TaskManager {
  late List<Task> tasks;
  late TaskStateContext taskStateContext;
  late TaskSortContext sortContext;
  late List<TaskObserverInterface> observers;

  TaskManager() {
    tasks = [];
    taskStateContext = TaskStateContext();
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
    notifyObservers();
  }

  void applyPriorityDecorator(Task task) {
    Task? updatedTask = tasks.firstWhereOrNull((element) => element == task);
    if (updatedTask == null) {
      return;
    }

    updatedTask = PriorityDecorator(task);
    tasks.remove(task);
    tasks.add(updatedTask);
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

    taskStateContext.setTaskState(state);
    taskStateContext.handleTaskStatus(task);
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
    for (var task in tasks) {
      print(task.toString());
    }
  }
}
