import 'package:brill_app/backend/model/note.dart';
import 'package:brill_app/backend/service/note_service.dart';
import 'package:get/get.dart';

class NoteController {
  var notes = <Note>[].obs;
  final NoteService noteService = NoteService();

  void fetchNotes() async {
    notes = (await noteService.fetchNotes()).obs;
  }

  void createNote(String title) async {
    Note note = await noteService.createNote(title);
    notes.add(note);
  }

  void updateNote(Note oldNote, Note newNote) async {
    await noteService.updateNote(newNote.title, newNote.content);
    var index = notes.indexOf(oldNote);
    notes[index] = newNote;
  }
}
