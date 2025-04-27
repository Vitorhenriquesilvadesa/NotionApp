import 'package:brill_app/features/editor/model/note.dart';
import 'package:brill_app/features/editor/service/editor_service.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  RxList<Note> notes = <Note>[].obs;
  NoteService noteService = NoteService();

  int get noteCount => notes.length;

  void create(Note note) {
    notes.add(note);
    notes.refresh();
  }

  void saveNote(Note note) {
    noteService.saveNote(note);
  }

  Note getByIndex(int index) {
    return notes[index];
  }

  void setTitle(int index, String title) {
    notes[index].title = title;
    notes.refresh();
  }

  void onReorder(int oldIndex, int newIndex) {
    final note = notes.removeAt(oldIndex);
    if (newIndex > oldIndex) newIndex--;
    notes.insert(newIndex, note);
    notes.refresh();
  }
}
