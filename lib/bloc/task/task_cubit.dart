import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/storage.dart';
import '../../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(super.initialState);

  setSortState({required int newSortState}) {
    var newState = TaskState(taskList: state.taskList, sortState: newSortState);
    emit(newState);
  }

  addNewTask({required Task task}) {
    var newTaskList = state.taskList;
    newTaskList.add(task);
    var newState = TaskState(taskList: newTaskList, sortState: state.sortState);
    emit(newState);
    Storage().saveTasks(newTaskList);
  }

  updateTask({required String taskId, required Task newTask}) {
    var newTaskList = state.taskList;

    Task targetTask =
        state.taskList.firstWhere((element) => element.id == taskId);

    newTaskList.remove(targetTask);

    targetTask.title = newTask.title;
    targetTask.priority = newTask.priority;
    targetTask.description = newTask.description;
    targetTask.color = newTask.color;
    targetTask.status = newTask.status;
    targetTask.date = newTask.date;

    newTaskList.add(targetTask);

    var newState = TaskState(taskList: newTaskList, sortState: state.sortState);
    emit(newState);

    Storage().saveTasks(newTaskList);
  }

  setTasks({required String tasksJson}) {
    var temp = jsonDecode(tasksJson);
    List<Task> taskList = [];
    for (var i = 0; i < temp.length; i++) {
      taskList.add(Task.fromJson(temp[i]));
    }

    var newState = TaskState(
      taskList: taskList,
      sortState: state.sortState,
    );
    emit(newState);
  }

  getTaskWithId({required String taskId}) {
    Task foundTask = state.taskList.firstWhere(
      (element) => element.id == taskId,
    );
    return foundTask;
  }
}
