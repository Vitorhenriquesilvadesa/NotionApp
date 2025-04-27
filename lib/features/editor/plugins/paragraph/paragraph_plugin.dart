import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/plugins/paragraph/model/paragraph_note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/note_element_plugin.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:brill_app/features/editor/plugins/paragraph/widgets/paragraph_composite_node.dart';
import 'package:flutter/material.dart';

class ParagraphPlugin implements NoteElementPlugin<ParagraphNoteElement> {
  @override
  BlockType get type => BlockType.paragraph;

  @override
  ParagraphNoteElement createElement(int noteId, String orderKey) {
    return ParagraphNoteElement(
      noteId: noteId,
      orderKey: orderKey,
      text: '',
      color: Colors.white,
      alignment: TextAlign.left,
      tag: ElementTag.normal,
    );
  }

  @override
  TextCompositeNode<ParagraphNoteElement> createWidget(
    ParagraphNoteElement element,
  ) {
    return ParagraphCompositeNode(element: element);
  }

  @override
  Map<String, dynamic> serialize(ParagraphNoteElement element) {
    return (element).toJson();
  }

  @override
  ParagraphNoteElement deserialize(Map<String, dynamic> json) {
    return ParagraphNoteElement.fromJson(json);
  }
}
