import 'package:brill_app/core/network/session_manager.dart';
import 'package:brill_app/features/editor/model/note.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/plugin_registry.dart';
import 'package:brill_app/features/notes/note_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditorController extends GetxController {
  Rxn<Note> activeNote = Rxn();

  SessionManager sessionManager = SessionManager();
  NoteController noteController = Get.find();
  TextEditingController titleController = TextEditingController();
  int activeNoteIndex = 0;

  String get pageTitle =>
      activeNote.value == null ? "" : activeNote.value!.title;

  set pageTitle(String title) {
    activeNote.value!.title = title;
    activeNote.refresh();
  }

  List<NoteElement> get elements => activeNote.value!.elements;

  void onSave() {
    noteController.saveNote(activeNote.value!);
  }

  void onPageTitleInsert(String title) {
    pageTitle = title;
    noteController.setTitle(activeNoteIndex, title);

    activeNote.value!.elements.add(
      NoteElementPluginRegistry()
          .get(BlockType.paragraph)!
          .createElement(activeNote.value!.id, "a"),
    );
  }

  int get elementCount => activeNote.value!.elements.length;

  void insertElement(int index, NoteElement element) {
    activeNote.value!.elements.insert(index, element);
    activeNote.refresh();
  }

  void reorderElement(int oldIndex, int newIndex) {
    final element = activeNote.value!.elements.removeAt(oldIndex);
    if (newIndex > oldIndex) newIndex--;
    activeNote.value!.elements.insert(newIndex, element);
    activeNote.refresh();
  }

  void openExistent(Note note) {
    activeNote.value = note;
    titleController.text = note.title;
  }

  void createAndOpen() {
    final note = Note(elements: [], id: 0, title: "No Title");
    activeNote.value = note;
    noteController.create(note);
    titleController.text = "";
    activeNoteIndex = noteController.notes.length - 1;
  }
}
