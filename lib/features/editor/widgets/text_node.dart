import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/model/element_text_style.dart';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ParagraphCompositeNode extends TextCompositeNode {
  ParagraphCompositeNode({
    required super.key,
    required super.focusNode,
    required super.index,
    required this.controller,
    required this.tag,
    this.onSubmitted,
    this.isDragging = false,
  });

  final void Function(String)? onSubmitted;
  final TextEditingController controller;
  ElementTag tag;
  final bool isDragging;

  @override
  TextCompositeNodeState<TextCompositeNode> createState() =>
      ParagraphCompositeNodeState();
}

class ParagraphCompositeNodeState
    extends TextCompositeNodeState<ParagraphCompositeNode> {
  Color color = Colors.white;
  TextStyle style = AppTextStyles.normal;

  @override
  Map<KeyCombination, VoidCallback> get keyHandlers => {
    KeyCombination(LogicalKeyboardKey.arrowUp): onUpPress,
    KeyCombination(LogicalKeyboardKey.arrowDown): onDownPress,
    KeyCombination(LogicalKeyboardKey.backspace): onDelete,
    KeyCombination(LogicalKeyboardKey.enter, {AppModifierKey.shiftModifier}):
        onShiftEnterPress,
  };

  bool _isCursorOnFirstLine() {
    var controller = widget.controller;
    var text = controller.text;
    var cursorPos = controller.selection.base.offset;
    String textAfterCursor = text.substring(cursorPos);
    var lineCount = text.split('\n').length;
    var afterCursorLineCount = textAfterCursor.split('\n').length;
    return afterCursorLineCount == lineCount;
  }

  bool _isCursorOnLastLine() {
    var controller = widget.controller;
    var text = controller.text;
    var cursorPos = controller.selection.base.offset;
    String textAfterCursor = text.substring(cursorPos);
    var afterCursorLineCount = textAfterCursor.split('\n').length;
    return afterCursorLineCount == 1;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.top,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onSubmitted: widget.onSubmitted,
      maxLines: null,
      style: style.copyWith(color: color),
      textAlign: TextAlign.justify,
      decoration: const InputDecoration.collapsed(hintText: ''),
      cursorColor: Theme.of(context).colorScheme.primary,
    );
  }

  void onDownPress() {
    if (_isCursorOnLastLine()) {
      //widget.onDownPress(widget.index);
    }
  }

  void onUpPress() {
    if (_isCursorOnFirstLine()) {
      //widget.onUpPress(widget.index);
    }
  }

  void onDelete() {
    final text = widget.controller.text;
    if (text.isEmpty) {
      //widget.onRemove();
    }
  }

  void onShiftEnterPress() {
    final text = widget.controller.text;
    final selection = widget.controller.selection;

    if (selection.start > 0 && text[selection.start - 1] == '\n') {
      final newText = text.replaceRange(
        selection.start - 1,
        selection.start,
        '',
      );
      widget.controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start - 1),
      );
    }

    //widget.onAddBelow();
  }

  void onColorChange(Color color) {
    setState(() {
      this.color = color;
    });
  }

  void onStyleChange(ElementTextStyle style) {
    setState(() {
      this.style = ElementTextStyles.styles[style]!;
    });
  }
}
