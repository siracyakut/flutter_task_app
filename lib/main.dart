import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/client/client_cubit.dart';
import 'bloc/task/task_cubit.dart';
import 'core/localizations.dart';
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
        BlocProvider(
          create: (context) => ClientCubit(
            ClientState(
                darkTheme: SchedulerBinding
                            .instance.platformDispatcher.platformBrightness ==
                        Brightness.dark
                    ? true
                    : false,
                language: !kIsWeb
                    ? AppLocalizations.isSupported(
                            Platform.localeName.split("_")[0])
                        ? Platform.localeName.split("_")[0]
                        : "en"
                    : "en"),
          ),
        ),
      ],
      child: BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
        return MaterialApp.router(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          debugShowCheckedModeBanner: false,
          themeMode: state.darkTheme ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: routes,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
          ],
          locale: Locale(state.language),
        );
      }),
    );
  }
}
