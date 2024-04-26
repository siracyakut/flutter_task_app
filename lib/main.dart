import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task/task_cubit.dart';
import 'core/routes.dart';
import 'core/themes.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(
            TaskState(
              sortState: 0,
              taskList: [],
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: routes,
      ),
    );
  }
}
