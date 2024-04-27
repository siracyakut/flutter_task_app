import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';

import '../bloc/task/task_cubit.dart';
import '../core/localizations.dart';
import '../models/task.dart';
import '../utils/dialogs.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int priorityIndex = 0;
  int colorIndex = 0;

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
  }

  addTask() {
    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      Dialogs().errorDialog(
        context: context,
        text: AppLocalizations.of(context).getTranslate("blanks"),
      );
      return;
    }

    Task newTask = Task(
      id: nanoid(),
      title: nameController.text,
      description: descriptionController.text,
      status: 0,
      priority: priorityIndex,
      color: colorList.elementAt(colorIndex),
      date: DateFormat('dd.MM.yyyy - kk:mm').format(DateTime.now()),
    );

    taskCubit.addNewTask(task: newTask);

    Dialogs().infoDialog(
      context: context,
      text: AppLocalizations.of(context).getTranslate("task-added"),
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
        title: Text(AppLocalizations.of(context).getTranslate("add-new-task")),
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
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)
                        .getTranslate("task-name-hint"),
                  ),
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    priorityItem(
                      text: AppLocalizations.of(context).getTranslate("asap"),
                      index: 0,
                    ),
                    priorityItem(
                      text: AppLocalizations.of(context).getTranslate("high"),
                      index: 1,
                    ),
                    priorityItem(
                      text: AppLocalizations.of(context).getTranslate("medium"),
                      index: 2,
                    ),
                    priorityItem(
                      text: AppLocalizations.of(context).getTranslate("low"),
                      index: 3,
                    ),
                  ],
                ),
                const Gap(20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).getTranslate(
                      "task-description-hint",
                    ),
                  ),
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const Gap(50),
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
          onTap: addTask,
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
                  AppLocalizations.of(context).getTranslate("add-task-button"),
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
}
