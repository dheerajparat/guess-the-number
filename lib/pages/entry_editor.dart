import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models.dart';

class EntryEditor extends StatefulWidget {
  final DiaryEntry? entry;

  const EntryEditor({super.key, this.entry});

  @override
  State<EntryEditor> createState() => _EntryEditorState();
}

class _EntryEditorState extends State<EntryEditor> {
  late TextEditingController _outputCtrl;
  late TextEditingController _frictionCtrl;
  late TextEditingController _correctionCtrl;
  late TextEditingController _pressureCtrl;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final e = widget.entry;
    _selectedDate = e?.date ?? DateTime.now();
    _outputCtrl = TextEditingController(text: e?.output.join('\n') ?? '');
    _frictionCtrl = TextEditingController(text: e?.friction.join('\n') ?? '');
    _correctionCtrl = TextEditingController(
      text: e?.correction.join('\n') ?? '',
    );
    _pressureCtrl = TextEditingController(text: e?.pressureLine ?? '');
  }

  @override
  void dispose() {
    _outputCtrl.dispose();
    _frictionCtrl.dispose();
    _correctionCtrl.dispose();
    _pressureCtrl.dispose();
    super.dispose();
  }

  List<String> _lines(TextEditingController c) {
    return c.text
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _selectedDate = d);
  }

  void _save() {
    final now = DateTime.now();
    final e = widget.entry;
    final id = e?.id ?? now.millisecondsSinceEpoch.toString();
    final entry = DiaryEntry(
      id: id,
      date: DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        now.hour,
        now.minute,
      ),
      output: _lines(_outputCtrl),
      friction: _lines(_frictionCtrl),
      correction: _lines(_correctionCtrl),
      pressureLine: _pressureCtrl.text.trim(),
    );
    Navigator.of(context).pop(entry);
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMMd();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry == null ? 'New entry' : 'Edit entry'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _save,
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(dateFmt.format(_selectedDate)),
                trailing: TextButton(
                  onPressed: _pickDate,
                  child: const Text('Change'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Output (one per line)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _outputCtrl,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Write outputs, each on new line',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Friction (one per line)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _frictionCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'What went wrong or blocked you',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Correction (one per line)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _correctionCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'How you will fix it',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Pressure Line',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _pressureCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'A single-line summary or motivational line',
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
