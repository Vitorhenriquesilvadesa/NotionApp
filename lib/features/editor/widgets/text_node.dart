import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextNode extends TextCompositeNode {
  const TextNode({
    required super.key,
    required super.element,
    required super.focusNode,
    required this.controller,
    required this.onAddBelow,
    required this.onAddAbove,
    required this.onRemove,
    required this.onDownPress,
    required this.onUpPress,
    required this.tag,
    this.onSubmitted,
    this.isDragging = false,
  });

  final void Function(String)? onSubmitted;
  final VoidCallback onAddAbove;
  final VoidCallback onAddBelow;
  final VoidCallback onRemove;
  final void Function(int) onDownPress;
  final void Function(int) onUpPress;
  final TextEditingController controller;
  final ElementTag tag;
  final bool isDragging;

  @override
  TextCompositeNodeState<TextCompositeNode> createState() => _TextNodeState();
}

class _TextNodeState extends TextCompositeNodeState<TextNode> {
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
      style: AppTextStyles.styles[widget.tag],
      textAlign: TextAlign.justify,
      decoration: const InputDecoration.collapsed(hintText: ''),
      cursorColor: Theme.of(context).colorScheme.primary,
    );
  }

  void onDownPress() {
    if (_isCursorOnLastLine()) {
      widget.onDownPress(widget.element.index);
    }
  }

  void onUpPress() {
    if (_isCursorOnFirstLine()) {
      widget.onUpPress(widget.element.index);
    }
  }

  void onDelete() {
    final text = widget.controller.text;
    if (text.isEmpty) {
      widget.onRemove();
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

    widget.onAddBelow();
  }
}
