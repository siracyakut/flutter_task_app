import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../services/api.dart';

class CacheManager {
  Future<Map<String, dynamic>?> getSplashScreenData() async {
    if (kIsWeb) {
      final data = await loadJsonFromAssets("assets/static/splash.json");
      return data;
    }

    API api = API();
    Map<String, dynamic>? splashFile = await loadJsonFromCache("splash.json");

    if (splashFile == null) {
      splashFile = await api.fetchSplashFiles();
    } else {
      final version = await api.getSplashFileVersion();
      if (version != splashFile["version"]) {
        splashFile = await api.fetchSplashFiles();
      }
    }

    return splashFile;
  }

  Future<List<String>> getCountryData() async {
    Map<String, dynamic>? data = {};
    List<String> countryNames = [];

    if (kIsWeb) {
      data = await loadJsonFromAssets("assets/static/countries.json");
    } else {
      data = await loadJsonFromCache("countries.json");
      data ??= await loadJsonFromAssets("assets/static/countries.json");
    }

    for (var el in data.keys) {
      countryNames.add(data[el]["name"] + " (${data[el]["alpha2Code"]})");
    }

    return countryNames;
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  Future<Map<String, dynamic>?> loadJsonFromCache(String filePath) async {
    final Directory appCacheDir = await getApplicationCacheDirectory();

    final file = File("${appCacheDir.path}/$filePath");

    if (file.existsSync()) {
      final fileData = await file.readAsString();
      return jsonDecode(fileData);
    } else {
      return null;
    }
  }

  saveJsonToCache(String filePath, String data) async {
    final Directory appCacheDir = await getApplicationCacheDirectory();
    final file = File("${appCacheDir.path}/$filePath");
    await file.writeAsString(jsonEncode(data), mode: FileMode.write);
  }
}
