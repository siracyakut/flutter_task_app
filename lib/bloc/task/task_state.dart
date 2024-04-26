part of 'task_cubit.dart';

class TaskState {
  final List<Map<String, Task>> taskList;
  final int sortState;

  TaskState({
    required this.taskList,
    required this.sortState,
  });
}
