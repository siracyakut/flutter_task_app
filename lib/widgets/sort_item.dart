import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task/task_cubit.dart';

class SortItem extends StatefulWidget {
  final int index;
  final String text;

  const SortItem({
    super.key,
    required this.index,
    required this.text,
  });

  @override
  State<SortItem> createState() => _SortItemState();
}

class _SortItemState extends State<SortItem> {
  late TaskCubit taskCubit;

  @override
  void initState() {
    super.initState();
    taskCubit = context.read<TaskCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      return GestureDetector(
        onTap: () => taskCubit.setSortState(newSortState: widget.index),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onBackground,
              width: 2,
            ),
            color: state.sortState == widget.index
                ? Theme.of(context).colorScheme.onBackground
                : Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: state.sortState == widget.index
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }
}
