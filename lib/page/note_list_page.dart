import 'package:flutter/material.dart';
import 'note_form_page.dart';
import '../database/db_helper.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final data = await DBHelper.getAll();
    setState(() => notes = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Mahasiswa')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteFormPage()),
          );
          loadData();
        },
      ),
      body: notes.isEmpty
          ? const Center(child: Text('Belum ada catatan'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final item = notes[index];
                return Card(
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Text(item['content']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NoteFormPage(note: item),
                              ),
                            );
                            loadData();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.delete(item['id']);
                            loadData();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
