# Task Management System

This Dart project is a simple window-based task management application that demonstrates the use of design patterns such as the Memento pattern for undo/redo functionality and various other design principles.

## Features

- **Task Creation:** Add tasks to the task list.
![Task Creation](imgs/image.png)
- **Display Tasks:** View and display the list of tasks.
![Display tasks](imgs/image-1.png)
- **Change Task Status:** Update the status of tasks.
![Change status](imgs/image-3.png)
- **Change Sort Type:** Change the sorting strategy for displaying tasks.
![Change sort type](imgs/image-4.png)
- **Undo/Redo Functionality:** Use undo and redo to navigate through task history.
![undo](imgs/image-5.png)
- **Add Deadline to Task:** Assign a deadline to a task for time-sensitive operations.
![Deadline](imgs/image-6.png)
- **Change Task Priority:** Adjust the priority level of tasks.
![Priority](imgs/image-7.png)
## Design Patterns Used

- **Memento Pattern:** Captures and externalizes the state of a task for undo and redo functionality.
- **Strategy Pattern:** Used for sorting tasks based on different strategies.
- **Observer Pattern:** Allows the observation of changes in tasks, such as saving to a text file.
- **Prototype Pattern:** Used for creating a copy of a task, allowing for efficient cloning of task instances.
- **Factory Pattern:** Employed for creating instances of tasks and task-related objects.
- **State Pattern:** Allows tasks to transition between different states, such as `To Do`, `In Progress`, and `Done`.
- **Singleton Pattern:** Ensures a single instance of critical components, enhancing efficiency and consistency, such as `TaskManager`.


## Getting Started

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/dart-task-management.git
    cd dart-task-management
    ```

2. Run application (intended for wider screens, such as tablets):

    ```bash
    flutter run
    ```

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

