import 'package:flutter/material.dart';
import 'package:project/_project.dart';

import 'widgets/_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements TaskObserverInterface {
  List<TaskInterface> _tasks = [];
  late TaskManager _taskManager;

  @override
  void update(List<TaskInterface> updatedTasks) {
    _tasks = updatedTasks.toList();

    setState(() {});
  }

  @override
  void initState() {
    _taskManager = TaskManager();
    _taskManager.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _taskManager.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  iconSize: 20.0,
                  onPressed: () {
                    _taskManager.undo();
                  },
                  icon: const Icon(Icons.undo),
                ),
                const SizedBox(width: 4.0),
                IconButton(
                  iconSize: 20.0,
                  onPressed: () {
                    _taskManager.redo();
                  },
                  icon: const Icon(Icons.redo),
                ),
              ],
            ),
            const Text('Task Management System'),
            IconButton(
              iconSize: 20.0,
              onPressed: () => ChangeSortDialog.show(
                context: context,
                initialStrategy: _taskManager.sortContext.strategy,
                onConfirm: (TaskSortStrategy sortStrategy) {
                  _taskManager.changeSortStrategy(sortStrategy);
                },
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('You have ${_tasks.length} tasks.',
                style: ThTextStyles.paragraphP2Medium.copyWith(
                  color: ThColors.textText1,
                  fontWeight: FontWeight.w600,
                )),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  TaskInterface task = _tasks[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(_tasks[index].toString()),
                      ),
                      Row(
                        children: <Widget>[
                          ThButton(
                            title: 'Change deadline',
                            onTap: () => ChangeDeadlineDialog.show(
                              context: context,
                              initialDeadline: task.deadline,
                              onConfirm: (DateTime deadline) {
                                _taskManager.addDeadline(task, deadline);
                              },
                            ),
                            size: ThPrimaryButtonSize.small,
                            style: ThPrimaryButtonStyle.primary,
                          ),
                          const SizedBox(width: 8.0),
                          ThButton(
                            title: 'Change priority',
                            onTap: () => ChangePriorityDialog.show(
                              context: context,
                              initialPriority: task.priority,
                              onConfirm: (Priority priority) {
                                _taskManager.addPriority(task, priority);
                              },
                            ),
                            size: ThPrimaryButtonSize.small,
                            style: ThPrimaryButtonStyle.primary,
                          ),
                          const SizedBox(width: 8.0),
                          DropdownMenu<int>(
                            key: ValueKey<String>(_tasks[index].description),
                            enableFilter: false,
                            requestFocusOnTap: true,
                            leadingIcon: const Icon(Icons.search),
                            initialSelection: _tasks[index].state.index,
                            label: const Text('Initial state'),
                            inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                            ),
                            onSelected: (int? selected) {
                              if (selected == null) {
                                return;
                              }

                              TaskState? state;

                              switch (selected) {
                                case 1:
                                  state = ToDoState();
                                  break;
                                case 2:
                                  state = InProgressState();
                                  break;
                                case 3:
                                  state = DoneState();
                                  break;
                                default:
                                  return;
                              }

                              _taskManager.changeTaskStatus(_tasks[index], state);

                              setState(() {});
                            },
                            dropdownMenuEntries: <int>[1, 2, 3].map<DropdownMenuEntry<int>>(
                              (int icon) {
                                return DropdownMenuEntry<int>(
                                  value: icon,
                                  label: icon == 1
                                      ? 'To Do'
                                      : icon == 2
                                          ? 'In Progress'
                                          : 'Done',
                                );
                              },
                            ).toList(),
                          ),
                          IconButton(
                            onPressed: () {
                              _taskManager.removeTask(_tasks[index]);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? result = await AddTaskDialog.show(context: context);
          if (result == null) {
            return;
          }

          _taskManager.addTask(result);
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
