import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../pages/todo_model.dart';

class TodoStorage {
  static const _fileName = 'todos.json';

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<List<TodoItem>> load() async {
    try {
      final f = await _file();
      if (!await f.exists()) return [];
      final s = await f.readAsString();
      final data = json.decode(s) as List<dynamic>;
      return data
          .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<TodoItem> items) async {
    final f = await _file();
    final data = items.map((e) => e.toJson()).toList();
    await f.writeAsString(json.encode(data));
  }
}
