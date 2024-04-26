import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/task/task_cubit.dart';
import '../models/task.dart';
import '../utils/dialogs.dart';

class EditTaskScreen extends StatefulWidget {
  final String id;

  const EditTaskScreen({
    super.key,
    required this.id,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int priorityIndex = 0;
  int colorIndex = 0;
  int statusIndex = 0;

  static const List<String> colorList = [
    "f44235",
    "2296f3",
    "ffeb3a",
    "4caf50",
    "9c27b0"
  ];

  late TaskCubit taskCubit;

  @override
  void initState() {
    super.initState();
    taskCubit = context.read<TaskCubit>();

    Task targetTask = taskCubit.getTaskWithId(taskId: widget.id);

    setState(() {
      statusIndex = targetTask.status;
      priorityIndex = targetTask.priority;
      colorIndex = colorList.indexOf(targetTask.color);
      nameController.text = targetTask.title;
      descriptionController.text = targetTask.description;
    });
  }

  saveTask() {
    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      Dialogs().errorDialog(
        context: context,
        text: "Please fill in the blanks.",
      );
      return;
    }

    Task newTask = Task(
      id: widget.id,
      title: nameController.text,
      description: descriptionController.text,
      status: statusIndex,
      priority: priorityIndex,
      color: colorList.elementAt(colorIndex),
      date: DateFormat('dd.MM.yyyy - kk:mm').format(DateTime.now()),
    );

    taskCubit.updateTask(newTask: newTask, taskId: widget.id);

    Dialogs().infoDialog(
      context: context,
      text: "Task has been successfully updated.",
      navigate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).replace("/home"),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        title: const Text("Edit task"),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Task name"),
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    priorityItem(text: "ASAP", index: 0),
                    priorityItem(text: "High", index: 1),
                    priorityItem(text: "Medium", index: 2),
                    priorityItem(text: "Low", index: 3),
                  ],
                ),
                const Gap(20),
                TextField(
                  controller: descriptionController,
                  decoration:
                      const InputDecoration(hintText: "Task description"),
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    colorItem(color: Colors.red, index: 0),
                    colorItem(color: Colors.blue, index: 1),
                    colorItem(color: Colors.yellow, index: 2),
                    colorItem(color: Colors.green, index: 3),
                    colorItem(color: Colors.purple, index: 4),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    statusItem(text: "To do", index: 0),
                    statusItem(text: "In process", index: 1),
                    statusItem(text: "Done", index: 2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: GestureDetector(
          onTap: saveTask,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Save task",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorItem({required Color color, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          colorIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(3.5),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorIndex == index
              ? Theme.of(context).colorScheme.onBackground
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget priorityItem({required String text, required int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          priorityIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20),
          color: priorityIndex == index
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.background,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: priorityIndex == index
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }

  Widget statusItem({required String text, required int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          statusIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20),
          color: statusIndex == index
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.background,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: statusIndex == index
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
