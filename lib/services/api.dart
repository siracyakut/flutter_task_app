import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../core/data.dart';

class API {
  getSplashFileVersion() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        "https://siracyakut.com/flutter/splash.json",
      );
      return response.data["version"];
    } on Exception catch (e) {
      return e;
    }
  }

  fetchSplashFiles() async {
    try {
      await downloadFile(
        "https://siracyakut.com/flutter/splash.json",
        "splash.json",
      );

      final json = await CacheManager().loadJsonFromCache("splash.json");
      await downloadFile(json!["logo"], "logo.png");

      return json;
    } on Exception catch (e) {
      return e;
    }
  }

  downloadFile(String url, String path) async {
    try {
      Dio dio = Dio();
      final Directory appCacheDir = await getApplicationCacheDirectory();
      await dio.download(url, "${appCacheDir.path}/$path");
      return true;
    } on Exception {
      return null;
    }
  }
}
