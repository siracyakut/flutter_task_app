import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/task/task_cubit.dart';
import '../core/localizations.dart';
import '../widgets/error_box.dart';
import '../widgets/sort_item.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  requestPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).getTranslate("home-title"),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(25),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SortItem(
                          index: 0,
                          text:
                              AppLocalizations.of(context).getTranslate("todo"),
                        ),
                        SortItem(
                          index: 1,
                          text: AppLocalizations.of(context)
                              .getTranslate("in-process"),
                        ),
                        SortItem(
                          index: 2,
                          text:
                              AppLocalizations.of(context).getTranslate("done"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                return Expanded(
                  flex: state.taskList
                          .where((element) => element.status == state.sortState)
                          .isNotEmpty
                      ? 1
                      : 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: state.taskList
                            .where(
                                (element) => element.status == state.sortState)
                            .isNotEmpty
                        ? ListView.builder(
                            itemCount: state.taskList
                                .where((element) =>
                                    element.status == state.sortState)
                                .length,
                            itemBuilder: (context, index) => TaskItem(
                              task: state.taskList
                                  .where((element) =>
                                      element.status == state.sortState)
                                  .elementAt(index),
                            ),
                          )
                        : ErrorBox(
                            text: AppLocalizations.of(context)
                                .getTranslate("no-task")),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Colors.transparent,
        height: 100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => GoRouter.of(context).replace("/home"),
                icon: Icon(
                  Icons.home_filled,
                  color: Theme.of(context).colorScheme.background,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () => GoRouter.of(context).replace("/settings"),
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.background,
                  size: 35,
                ),
              ),
              Transform(
                transform: Matrix4(
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                )
                  ..rotateX(120)
                  ..rotateY(25)
                  ..rotateZ(0),
                alignment: FractionalOffset.center,
                child: InkWell(
                  onTap: () => GoRouter.of(context).replace("/add-task"),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
