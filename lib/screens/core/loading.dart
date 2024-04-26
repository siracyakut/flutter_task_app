// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/task/task_cubit.dart';
import '../../core/storage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late TaskCubit taskCubit;

  checkFirstLaunch() async {
    var storage = Storage();
    var isFirstLaunch = await storage.isFirstLaunch();
    if (isFirstLaunch != null) {
      GoRouter.of(context).replace("/home");
    } else {
      GoRouter.of(context).replace("/boarding");
    }
  }

  loadApp() async {
    // await Storage().clearAllForDebug();
    var json = await Storage().getTasks();
    if (json != null) {
      taskCubit.setTasks(tasksJson: json);
    }
  }

  @override
  void initState() {
    taskCubit = context.read<TaskCubit>();
    checkFirstLaunch();
    loadApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
