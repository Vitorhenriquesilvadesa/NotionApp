import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/model/paragraph_note_element.dart';
import 'package:brill_app/features/editor/plugins/block_plugin.dart';
import 'package:brill_app/features/editor/plugins/block_type.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/paragraph_composite_node.dart';
import 'package:flutter/material.dart';

class ParagraphPlugin implements NoteElementPlugin {
  @override
  BlockType get type => BlockType.paragraph;

  @override
  NoteElement createElement() {
    return ParagraphNoteElement(
      text: '',
      color: Colors.white,
      alignment: TextAlign.left,
      tag: ElementTag.normal,
    );
  }

  @override
  TextCompositeNode createWidget(NoteElement element) {
    return ParagraphCompositeNode(element: element as ParagraphNoteElement);
  }

  @override
  Map<String, dynamic> serialize(NoteElement element) {
    return (element as ParagraphNoteElement).toJson();
  }

  @override
  NoteElement deserialize(Map<String, dynamic> json) {
    return ParagraphNoteElement.fromJson(json);
  }
}
