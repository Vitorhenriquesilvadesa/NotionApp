import 'package:brill_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextNode extends StatefulWidget {
  const TextNode({
    required super.key,
    required this.index,
    required this.elementType,
    required this.controller,
    required this.focusNode,
    required this.onAddBelow,
    required this.onAddAbove,
    required this.onRemove,
    this.onSubmitted,
    this.isDragging = false,
  });

  final int index;
  final ElementType elementType;
  final void Function(String)? onSubmitted;
  final FocusNode focusNode;
  final VoidCallback onAddAbove;
  final VoidCallback onAddBelow;
  final VoidCallback onRemove;
  final TextEditingController controller;
  final bool isDragging;

  @override
  State<TextNode> createState() => _TextNodeState();
}

class _TextNodeState extends State<TextNode> {
  bool _hovering = false;

  void _onKeyPressed(KeyEvent keyEvent) {
    if (keyEvent is KeyDownEvent) {
      if (HardwareKeyboard.instance.isShiftPressed &&
          keyEvent.logicalKey == LogicalKeyboardKey.enter) {
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

      if (keyEvent.logicalKey == LogicalKeyboardKey.backspace) {
        if (widget.controller.value.text.isEmpty) {
          widget.onRemove();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      onKeyEvent: _onKeyPressed,
      focusNode: FocusNode(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  _hovering ? Colors.white.withAlpha(30) : Colors.transparent,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    onSubmitted: widget.onSubmitted,
                    maxLines: null,
                    style: AppTextStyles.styles[widget.elementType],
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    cursorColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _hovering ? 1.0 : 0.25,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ReorderableDragStartListener(
                      index: widget.index,
                      child: const Icon(
                        Icons.drag_indicator_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
