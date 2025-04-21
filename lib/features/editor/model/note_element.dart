import 'package:flutter/material.dart';

enum ElementType { text, list, code, image, heading, quote }

abstract class NoteElement {
  final ElementType type;
  final FocusNode focusNode;
  int index;

  NoteElement({
    required this.index,
    required this.type,
    required this.focusNode,
  });
}

class TextNoteElement extends NoteElement {
  final TextEditingController controller;
  TextAlign alignment;

  TextNoteElement({
    required super.focusNode,
    required super.index,
    required this.controller,
    this.alignment = TextAlign.left,
  }) : super(type: ElementType.text);
}

class ListNoteElement extends NoteElement {
  final List<ListItem> items;

  ListNoteElement({
    required super.index,
    required super.type,
    required super.focusNode,
    required this.items,
  });
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
    required super.type,
    required super.focusNode,
    required this.controller,
    this.language = 'java',
  });
}

class ImageNoteElement extends NoteElement {
  final String imageUrl;

  ImageNoteElement({
    required super.index,
    required super.type,
    required super.focusNode,
    required this.imageUrl,
  });
}
