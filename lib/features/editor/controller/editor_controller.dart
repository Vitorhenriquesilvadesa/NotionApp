import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/block_type.dart';
import 'package:brill_app/features/editor/plugins/plugin_registry.dart';
import 'package:flutter/cupertino.dart';

class EditorController extends ChangeNotifier {
  final List<NoteElement> elements = [];

  int get elementCount => elements.length;

  void insertElement(int index, NoteElement element) {
    elements.insert(index, element);
    notifyListeners();
  }

  void onPageTitleInsert(String title) {
    final paragraphPlugin = NoteElementPluginRegistry().get(
      BlockType.paragraph,
    );

    if (elements.isEmpty) {
      var element = paragraphPlugin?.createElement();
      elements.add(element!);
    }
  }
}
