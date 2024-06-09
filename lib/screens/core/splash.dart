// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import '../../bloc/client/client_cubit.dart';
import '../../bloc/task/task_cubit.dart';
import '../../core/data.dart';
import '../../core/storage.dart';
import '../../services/api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late TaskCubit taskCubit;
  late ClientCubit clientCubit;
  late Directory cacheDir;
  Map<String, dynamic> splashData = {};
  bool loaded = false;

  checkFirstLaunch() async {
    var storage = Storage();
    var isFirstLaunch = await storage.isFirstLaunch();
    if (isFirstLaunch != null) {
      context.go("/home");
    } else {
      context.go("/boarding");
    }
  }

  loadApp() async {
    // await Storage().clearAllForDebug();
    var json = await Storage().getTasks();
    if (json != null) {
      taskCubit.setTasks(tasksJson: json);
    }

    var config = await Storage().getConfig();
    if (config["theme"] != null) {
      clientCubit.setTheme(newTheme: config["theme"]);
    }
    if (config["language"] != null) {
      clientCubit.setLanguage(newLanguage: config["language"]);
    }
  }

  getSplashData() async {
    if (!kIsWeb) {
      CacheManager cm = CacheManager();
      API api = API();

      Map<String, dynamic>? splashFile =
          await cm.loadJsonFromCache("splash.json");

      if (splashFile == null) {
        splashFile = await api.fetchSplashFiles();
      } else {
        final version = await api.getSplashFileVersion();
        if (version != splashFile["version"]) {
          splashFile = await api.fetchSplashFiles();
        }
      }

      cacheDir = await getApplicationCacheDirectory();

      setState(() {
        splashData = splashFile!;
        loaded = true;
      });

      Future.delayed(Duration(milliseconds: splashFile!["duration"]), () {
        checkFirstLaunch();
      });
    }
  }

  @override
  void initState() {
    taskCubit = context.read<TaskCubit>();
    clientCubit = context.read<ClientCubit>();
    loadApp();
    getSplashData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !loaded
            ? const SizedBox.expand()
            : BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
                return SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.file(
                          File("${cacheDir.path}/logo.png"),
                          width: 150,
                        ),
                        Column(
                          children: [
                            Text(
                              splashData["title"],
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(5),
                            Text(
                              splashData["slogans"][state.language][Random()
                                  .nextInt(splashData["slogans"][state.language]
                                      .length)],
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const CircularProgressIndicator(),
                            const Gap(15),
                            Text("v${splashData["version"]}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
      ),
    );
  }
}
