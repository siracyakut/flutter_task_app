import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_task.dart';
import '../screens/core/error.dart';
import '../screens/core/splash.dart';
import '../screens/edit_task.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../screens/settings.dart';
import '../screens/static/boarding.dart';
import '../screens/static/layout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => LayoutScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
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
