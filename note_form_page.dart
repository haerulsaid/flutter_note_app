import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_storage.dart';

class NoteFormPage extends StatefulWidget {
  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notes = await NoteStorage.loadNotes();
  }

  void saveNote() async {
    notes.add(Note(
      title: titleCtrl.text,
      content: contentCtrl.text,
    ));
    await NoteStorage.saveNotes(notes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Catatan')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: contentCtrl,
              decoration: InputDecoration(labelText: 'Isi'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNote,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
