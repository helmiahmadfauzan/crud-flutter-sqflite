import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class NoteFormPage extends StatefulWidget {
  final Map<String, dynamic>? note;
  const NoteFormPage({super.key, this.note});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!['title'];
      contentController.text = widget.note!['content'];
    }
  }

  void saveData() async {
    if (widget.note == null) {
      await DBHelper.insert({
        'title': titleController.text,
        'content': contentController.text,
      });
    } else {
      await DBHelper.update({
        'id': widget.note!['id'],
        'title': titleController.text,
        'content': contentController.text,
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Tambah Catatan' : 'Edit Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Isi Catatan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveData, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }
}
