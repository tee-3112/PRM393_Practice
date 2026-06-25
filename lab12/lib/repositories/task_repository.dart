import '../models/task.dart';

class TaskRepository {

  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
  }

  void updateTask(
      int index,
      Task task,
      ) {

    _tasks[index] = task;
  }
}