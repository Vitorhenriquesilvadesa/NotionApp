import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:flutter/material.dart';

final class NoteElementTemplates {
  static ParagraphNoteElement textNoteElement(int index) {
    return ParagraphNoteElement(
      color: Colors.white,
      controller: TextEditingController(),
      focusNode: FocusNode(),
      key: GlobalKey(),
      index: index,
      alignment: TextAlign.left,
      tag: ElementTag.h5,
    );
  }
}
