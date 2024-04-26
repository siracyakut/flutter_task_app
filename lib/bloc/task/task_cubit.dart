import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(super.initialState);

  setSortState({required int newSortState}) {
    var newState = TaskState(taskList: state.taskList, sortState: newSortState);
    emit(newState);
  }
}
