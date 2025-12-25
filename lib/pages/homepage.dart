import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/pages/models.dart';
import 'package:flutter_application_1/services/storage.dart';
import 'entry_editor.dart';
import 'view_entry.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomepageState();
}

// (Entries are loaded from local storage)

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMd().add_jm();
    return Scaffold(
      body: SafeArea(
        child: _entries.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.note_alt_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No entries yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Tap + to create your first note.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, i) {
                  final e = _entries[i];
                  final scheme = Theme.of(context).colorScheme;
                  final avatarBg = scheme.secondary.withAlpha(
                    (0.12 * 255).round(),
                  );
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: avatarBg,
                        child: Text(
                          '${e.date.day}',
                          style: TextStyle(color: scheme.secondary),
                        ),
                      ),
                      title: Hero(
                        tag: 'entry_title_${e.id}',
                        child: Text(
                          dateFmt.format(e.date.toLocal()),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      // subtitle: Text(_subtitleFor(e)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final res = await Navigator.of(context).push<dynamic>(
                          MaterialPageRoute(
                            builder: (_) => ViewEntry(entry: e),
                          ),
                        );
                        if (res is DiaryEntry) {
                          setState(() => _entries[i] = res);
                          await _saveEntries();
                        } else if (res is Map && res['action'] == 'delete') {
                          await _deleteEntry(i);
                        }
                      },
                      onLongPress: () => _deleteEntry(i),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addOrEditEntry(),
        icon: const Icon(Icons.add),

        label: const Text('Add'),
      ),
    );
  }

  final StorageService _storage = StorageService();
  List<DiaryEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final list = await _storage.loadEntries();
    list.sort((a, b) => b.date.compareTo(a.date));
    setState(() => _entries = list);
  }

  Future<void> _saveEntries() async {
    await _storage.saveEntries(_entries);
  }

  Future<void> _addOrEditEntry({DiaryEntry? entry, int? index}) async {
    final result = await Navigator.of(context).push<DiaryEntry>(
      MaterialPageRoute(builder: (_) => EntryEditor(entry: entry)),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          _entries[index] = result;
        } else {
          _entries.add(result);
        }
        _entries.sort((a, b) => b.date.compareTo(a.date));
      });
      await _saveEntries();
    }
  }

  Future<void> _deleteEntry(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete entry?'),
        content: const Text('This action cannot be undone.'),
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
      setState(() => _entries.removeAt(index));
      await _saveEntries();
    }
  }

  String _subtitleFor(DiaryEntry e) {
    final o = e.output.length;
    final f = e.friction.length;
    final c = e.correction.length;
    return 'Output:$o  Friction:$f  Correction:$c';
  }
}
