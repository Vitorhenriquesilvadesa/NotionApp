import 'package:brill_app/features/editor/widgets/code_composite_node.dart';
import 'package:flutter/material.dart';

class CodeController extends ChangeNotifier {
  final TextEditingController textEditingController;
  CodeMode mode = CodeMode.editing;
  String language;

  String get source => textEditingController.text;

  CodeController({required this.language, required this.textEditingController});

  void setMode(CodeMode mode) {
    this.mode = mode;
    notifyListeners();
  }

  void setLanguage(String language) {
    this.language = language;
    notifyListeners();
  }

  void setSource(String source) {
    textEditingController.text = source;
    notifyListeners();
  }
}
