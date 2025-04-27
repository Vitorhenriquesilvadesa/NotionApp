import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:flutter/material.dart';

class ParagraphNoteElement extends NoteElement {
  TextAlign alignment;
  ElementTag tag;
  Color color;
  String text;

  ParagraphNoteElement({
    required this.color,
    required this.text,
    required super.noteId,
    required super.orderKey,
    this.tag = ElementTag.h5,
    this.alignment = TextAlign.left,
  }) : super(type: BlockType.paragraph);

  factory ParagraphNoteElement.fromJson(Map<String, dynamic> json) {
    return ParagraphNoteElement(
      noteId: json['noteId'],
      orderKey: json['orderKey'],
      alignment: json['alignment'],
      tag: json['tag'],
      color: json['color'],
      text: json['text'],
    );
  }

  @override
  String toString() {
    return "Paragraph { $color, $tag, $alignment, $text }";
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
