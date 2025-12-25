import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'todo_model.dart';
import '../services/todo_storage.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoStorage _storage = TodoStorage();
  List<TodoItem> _items = [];
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await _storage.load();
    setState(() => _items = list);
  }

  Future<void> _save() async {
    await _storage.save(_items);
  }

  Future<void> _add() async {
    final title = await showDialog<String>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('New todo'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Todo title'),
          onSubmitted: (v) => Navigator.pop(c, v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    if (title != null && title.trim().isNotEmpty) {
      final item = TodoItem(id: _uuid.v4(), title: title.trim());
      setState(() => _items.insert(0, item));
      await _save();
    }
  }

  Future<void> _toggle(int i) async {
    setState(() => _items[i].done = !_items[i].done);
    await _save();
  }

  Future<void> _delete(int i) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) {
      setState(() => _items.removeAt(i));
      await _save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMd().add_jm();
    return Scaffold(
      body: SafeArea(
        child: _items.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.checklist,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No todos yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Tap + to add a todo.'),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final it = _items[i];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: it.done,
                        onChanged: (_) => _toggle(i),
                      ),
                      title: Text(
                        it.title,
                        style: TextStyle(
                          decoration: it.done
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(dateFmt.format(it.createdAt)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _delete(i),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}
