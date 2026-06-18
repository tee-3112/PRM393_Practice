import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {

  Future<File> getFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    return File(
      '${directory.path}/students.json',
    );
  }

  Future<void> saveData(List data) async {

    final file = await getFile();

    await file.writeAsString(
      jsonEncode(data),
    );
  }

  Future<List<dynamic>> loadData() async {

    try {

      final file = await getFile();

      if (await file.exists()) {

        String content =
        await file.readAsString();

        return jsonDecode(content);
      }

      String assetData =
      await rootBundle.loadString(
        'assets/students.json',
      );

      return jsonDecode(assetData);

    } catch (e) {

      return [];
    }
  }
}