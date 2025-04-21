import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/service/editor_service.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditorController extends GetxController {
  FocusNode pageTitleFocusNode = FocusNode();
  List<NoteElement> elements = [];
  late int editingIndex;

  final EditorService editorService = Get.find();

  get elementCount => elements.length;

  NoteElement insertElementAt(int index, NoteElement element) {
    element.index = index;
    elements.insert(index, element);
    return element;
  }

  NoteElement removeByIndex(int index) {
    return elements.removeAt(index);
  }

  NoteElement getByIndex(int index) => elements[index];

  set index(int value) {
    editingIndex = value;
  }

  void onPageTitleInsert(String title) {
    if (elements.isEmpty) {
      FocusNode focusNode = FocusNode();
      var controller = TextEditingController();
      var element = TextNoteElement(
        index: 0,
        focusNode: focusNode,
        controller: controller,
      );
      elements.add(element);
      focusNode.requestFocus();
      editingIndex = 0;
    }
  }

  void insertAt(int index) {
    FocusNode focusNode = FocusNode();
    var controller = TextEditingController();
    var element = TextNoteElement(
      index: index,
      focusNode: focusNode,
      controller: controller,
    );
    elements.insert(index, element);
    focusNode.requestFocus();
    editingIndex = index;
  }

  void removeElementAt(int index) {
    elements.removeAt(index);
    if (index > 0) {
      elements[index - 1].focusNode.requestFocus();
      editingIndex = index - 1;
    } else {
      elements[0].focusNode.requestFocus();
      editingIndex = 0;
    }
  }

  void swapTo(int index) {
    if (index > -1) {
      debugPrint("Swapping to: $index");
      elements[index].focusNode.requestFocus();
      editingIndex = index;
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageTitleFocusNode.dispose();

    for (var element in elements) {
      element.focusNode.dispose();
    }
  }
}
