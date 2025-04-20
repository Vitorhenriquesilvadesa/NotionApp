import 'package:brill_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class NoteElement {
  final ElementType type;
  final FocusNode focusNode;
  final TextEditingController controller;

  NoteElement({
    required this.type,
    required this.focusNode,
    required this.controller,
  });
}
