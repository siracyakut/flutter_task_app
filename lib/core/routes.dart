import 'package:go_router/go_router.dart';

import '../screens/add_task.dart';
import '../screens/core/error.dart';
import '../screens/core/loading.dart';
import '../screens/edit_task.dart';
import '../screens/home.dart';
import '../screens/static/boarding.dart';

final routes = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-task',
      builder: (context, state) => const AddTaskScreen(),
    ),
    GoRoute(
      path: '/edit-task/:id',
      name: 'edit-task',
      builder: (context, state) => EditTaskScreen(
        id: state.pathParameters["id"]!,
      ),
    ),
  ],
);
