import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class Storage {
  isFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLaunched = prefs.getBool("launchedBefore");
    if (isLaunched == null) {
      await prefs.setBool("launchedBefore", true);
    }
    return isLaunched;
  }

  saveTasks(List<Task> taskList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("tasks", jsonEncode(taskList));
  }

  getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tasks = prefs.getString("tasks");
    return tasks;
  }

  // for debugging
  clearAllForDebug() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  saveLanguage({required String language}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", language);
  }

  saveTheme({required bool darkTheme}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("theme", darkTheme);
  }

  getConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? language = prefs.getString("language");
    final bool? theme = prefs.getBool("theme");
    return {"language": language, "theme": theme};
  }
}
