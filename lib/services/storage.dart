import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../pages/models.dart';

class StorageService {
  static const _fileName = 'diary_entries.json';

  Future<File> _localFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<List<DiaryEntry>> loadEntries() async {
    try {
      final file = await _localFile();
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      final data = json.decode(content) as List<dynamic>;
      return data
          .map((e) => DiaryEntry.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveEntries(List<DiaryEntry> entries) async {
    final file = await _localFile();
    final data = entries.map((e) => e.toJson()).toList();
    await file.writeAsString(json.encode(data));
  }
}
