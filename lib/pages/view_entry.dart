import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models.dart';
import 'entry_editor.dart';

class ViewEntry extends StatelessWidget {
  final DiaryEntry entry;

  const ViewEntry({super.key, required this.entry});

  Future<void> _confirmDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete entry?'),
        content: const Text('This will permanently delete the entry.'),
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
    if (ok == true) Navigator.of(context).pop({'action': 'delete'});
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMd().add_jm();
    return Scaffold(
      appBar: AppBar(
        title: Text(dateFmt.format(entry.date.toLocal())),
        actions: [
          IconButton(
            tooltip: "Edit entry",
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final edited = await Navigator.of(context).push<DiaryEntry>(
                MaterialPageRoute(builder: (_) => EntryEditor(entry: entry)),
              );
              if (edited != null) Navigator.of(context).pop(edited);
            },
          ),
          IconButton(
            tooltip: "Delete entry",
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Hero(
                tag: 'entry_title_${entry.id}',
                child: Text(dateFmt.format(entry.date.toLocal())),
              ),
            ),
            const SizedBox(height: 12),
            if (entry.pressureLine.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    entry.pressureLine,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            _section('Output', entry.output),
            const SizedBox(height: 8),
            _section('Friction', entry.friction),
            const SizedBox(height: 8),
            _section('Correction', entry.correction),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...items.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text('• $s'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
