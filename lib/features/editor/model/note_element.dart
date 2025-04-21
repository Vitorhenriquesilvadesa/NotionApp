import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/utils/text_element_visitor.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:flutter/material.dart';

enum ElementType { paragraph, list, code, image, heading, quote }

abstract class NoteElement {
  final ElementType type;
  FocusNode focusNode;
  GlobalKey<TextCompositeNodeState<TextCompositeNode>> key;
  int index;

  NoteElement({
    required this.key,
    required this.index,
    required this.type,
    required this.focusNode,
  });

  T accept<T>(NoteElementVisitor<T> visitor);

  @override
  String toString() {
    return "Element { $type, $key }";
  }
}

class ParagraphNoteElement extends NoteElement {
  final TextEditingController controller;
  TextAlign alignment;
  ElementTag tag;
  Color color;

  ParagraphNoteElement({
    required super.focusNode,
    required super.index,
    required super.key,
    required this.color,
    required this.controller,
    this.tag = ElementTag.h5,
    this.alignment = TextAlign.left,
  }) : super(type: ElementType.paragraph);

  @override
  T accept<T>(NoteElementVisitor<T> visitor) {
    return visitor.visitText(this);
  }

  @override
  String toString() {
    return "Paragraph { $type, , $controller, $key }";
  }
}

class ListNoteElement extends NoteElement {
  final List<ListItem> items;

  ListNoteElement({
    required super.index,
    required super.type,
    required super.focusNode,
    required this.items,
    required super.key,
  });

  @override
  T accept<T>(NoteElementVisitor<T> visitor) {
    return visitor.visitList(this);
  }
}

class ListItem {
  final TextEditingController controller;
  bool checked;

  ListItem({required this.controller, this.checked = false});
}

class CodeNoteElement extends NoteElement {
  final TextEditingController controller;
  final String language;

  CodeNoteElement({
    required super.index,
    required super.focusNode,
    required super.key,
    required this.controller,
    this.language = 'java',
  }) : super(type: ElementType.code);

  @override
  T accept<T>(NoteElementVisitor<T> visitor) {
    return visitor.visitCode(this);
  }
}

class ImageNoteElement extends NoteElement {
  final String imageUrl;

  ImageNoteElement({
    required super.index,
    required super.type,
    required super.focusNode,
    required this.imageUrl,
    required super.key,
  });

  @override
  T accept<T>(NoteElementVisitor<T> visitor) {
    return visitor.visitImage(this);
  }
}
