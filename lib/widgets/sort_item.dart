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
      return InkWell(
        onTap: () => taskCubit.setSortState(newSortState: widget.index),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(20, 20, 20, 1),
              width: 2,
            ),
            color: state.sortState == widget.index
                ? const Color.fromRGBO(20, 20, 20, 1)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: state.sortState == widget.index
                  ? Colors.white
                  : const Color.fromRGBO(20, 20, 20, 1),
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }
}
