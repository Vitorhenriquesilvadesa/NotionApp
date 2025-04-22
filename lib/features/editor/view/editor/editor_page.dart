import 'package:brill_app/features/editor/view/editor/activity_bar.dart';
import 'package:brill_app/features/editor/view/editor/editor_note_space.dart';
import 'package:flutter/material.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ActivityBar(), EditorNoteSpace()],
      ),
    );
  }
}
