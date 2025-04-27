import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class TextCompositeNode<T extends NoteElement> extends StatefulWidget {
  const TextCompositeNode({super.key, required this.element});

  final T element;

  @override
  TextCompositeNodeState createState();
}

abstract class TextCompositeNodeState<T extends TextCompositeNode>
    extends State<T> {
  Map<KeyCombination, VoidCallback> get keyHandlers;

  @override
  void dispose() {
    super.dispose();
  }
}

// ignore: must_be_immutable
class TextElement extends StatefulWidget {
  TextElement({super.key, required this.index, required this.childBuilder});

  int index;
  final TextCompositeNode Function() childBuilder;

  @override
  State<TextElement> createState() => _TextElementState();
}

class _TextElementState extends State<TextElement> {
  bool _hovering = false;
  late final TextCompositeNode child;

  @override
  void initState() {
    super.initState();
    child = widget.childBuilder();
  }

  // void _onKeyPressed(KeyEvent keyEvent) {
  //   final state = widget.childKey.currentState;
  //   if (state == null) return;

  //   switch (keyEvent.runtimeType) {
  //     case const (KeyDownEvent):
  //       onKeyPress(keyEvent);
  //       break;
  //     case const (KeyUpEvent):
  //       onKeyRelease(keyEvent);
  //       break;
  //   }
  // }

  // void onKeyPress(KeyEvent event) {
  //   final state = widget.childKey.currentState;

  //   if (state == null) return;
  //   if (event is! KeyDownEvent) return;

  //   final keyboard = HardwareKeyboard.instance;

  //   final modifiers = <AppModifierKey>{
  //     if (keyboard.isShiftPressed) AppModifierKey.shiftModifier,
  //     if (keyboard.isControlPressed) AppModifierKey.controlModifier,
  //     if (keyboard.isAltPressed) AppModifierKey.altModifier,
  //     if (keyboard.isMetaPressed) AppModifierKey.metaModifier,
  //   };

  //   final combination = KeyCombination(event.logicalKey, modifiers);
  //   final callback = state.keyHandlers[combination];
  //   callback?.call();
  // }

  // void onKeyRelease(KeyEvent event) {}

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          //_onKeyPressed(event);
        }
        return KeyEventResult.ignored;
      },
      focusNode: FocusNode(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _hovering ? Colors.white.withAlpha(30) : Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
