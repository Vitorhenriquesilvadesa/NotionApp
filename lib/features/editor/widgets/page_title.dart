import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageTitle extends StatefulWidget {
  const PageTitle({super.key, this.onSubmitted});

  final void Function(String)? onSubmitted;

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(KeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (widget.onSubmitted != null) {
        widget.onSubmitted!(_controller.text);
      }
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter:
          (_) => setState(() {
            _hovering = true;
          }),
      onExit:
          (_) => setState(() {
            _hovering = false;
          }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _hovering ? Colors.white.withAlpha(30) : Colors.transparent,
        ),
        child: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: _onKey,
          child: Container(
            child: TextField(
              controller: _controller,
              maxLines: null,
              cursorHeight: 48,
              cursorWidth: 3,
              cursorRadius: Radius.circular(20),
              textAlign: TextAlign.left,
              decoration: const InputDecoration.collapsed(hintText: ''),
              style: AppTextStyles.styles[ElementType.title],
              cursorColor: AppColorsDark.defaultText,
            ),
          ),
        ),
      ),
    );
  }
}
