import 'package:brill_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ParagraphController extends ChangeNotifier {
  final TextEditingController textEditingController;
  ElementTag tag;
  TextAlign align;
  Color color;

  ParagraphController({
    required this.textEditingController,
    this.tag = ElementTag.h5,
    this.align = TextAlign.left,
    this.color = Colors.black,
  });

  String get text => textEditingController.text;

  void setTag(ElementTag tag) {
    this.tag = tag;
    notifyListeners();
  }

  void setColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  TextStyle getTextStyle() {
    return AppTextStyles.styles[tag]!.copyWith(color: color);
  }

  void setAlignment(TextAlign align) {
    this.align = align;
    notifyListeners();
  }
}
