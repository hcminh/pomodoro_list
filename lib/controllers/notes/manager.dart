import 'database.dart';
import '../../models/note.dart';

class NoteManager {
  Future<List<Note>> notesData;

  addNewNote(Note note) async {
    await DatabaseNote.db.insert(note);
  }

  updateNote(Note note) async {
    await DatabaseNote.db.update(note);
  }

  removeNote(Note note) async {
    await DatabaseNote.db.remove(note);
  }

  loadAllNotes() {
    notesData = DatabaseNote.db.getAll();
  }

  loadNotes(int limit) {
    notesData = DatabaseNote.db.getMany(limit);
  }
}
