import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  isFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLaunched = prefs.getBool("launchedBefore");
    if (isLaunched == null) {
      await prefs.setBool("launchedBefore", true);
    }
    return isLaunched;
  }
}
