import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_storage.dart';
import 'note_form_page.dart';
import 'note_detail_page.dart';

class NoteListPage extends StatefulWidget {
  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notes = await NoteStorage.loadNotes();
    setState(() {});
  }

  void deleteNote(int index) async {
    notes.removeAt(index);
    await NoteStorage.saveNotes(notes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(notes[i].title),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NoteDetailPage(note: notes[i]),
              ),
            );
            loadNotes();
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => deleteNote(i),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteFormPage()),
          );
          loadNotes();
        },
      ),
    );
  }
}
