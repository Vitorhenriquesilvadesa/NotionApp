import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/service/editor_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditorController extends GetxController {
  FocusNode pageTitleFocusNode = FocusNode();
  List<NoteElement> elements = [];
  late int _editingIndex;

  final EditorService editorService = Get.find();

  get elementCount => elements.length;

  NoteElement insert(int index, NoteElement element) {
    elements.insert(index, element);
    return element;
  }

  NoteElement removeByIndex(int index) {
    return elements.removeAt(index);
  }

  NoteElement getByIndex(int index) => elements[index];
  set index(int value) {
    _editingIndex = value;
  }

  void onPageTitleInsert(String title) {
    if (elements.isEmpty) {
      FocusNode focusNode = FocusNode();
      var controller = TextEditingController();
      var element = NoteElement(
        type: ElementTag.h5,
        focusNode: focusNode,
        controller: controller,
      );
      elements.add(element);
      focusNode.requestFocus();
      _editingIndex = 0;
    }
  }

  void insertElementAt(int index) {
    FocusNode focusNode = FocusNode();
    var controller = TextEditingController();
    var element = NoteElement(
      type: ElementTag.h5,
      focusNode: focusNode,
      controller: controller,
    );
    elements.insert(index, element);
    focusNode.requestFocus();
    _editingIndex = index;
  }

  void removeElementAt(int index) {
    elements.removeAt(index);
    if (index > 0) {
      elements[index - 1].focusNode.requestFocus();
      _editingIndex = index - 1;
    } else {
      elements[0].focusNode.requestFocus();
      _editingIndex = 0;
    }
  }

  void swapTo(int index) {
    if (index > 0) {
      elements[index].focusNode.requestFocus();
      _editingIndex = index;
    } else {
      elements[0].focusNode.requestFocus();
      _editingIndex = 0;
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
