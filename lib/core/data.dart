import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
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
