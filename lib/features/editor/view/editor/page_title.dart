import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageTitle extends StatefulWidget {
  const PageTitle({
    super.key,
    this.onSubmitted,
    required this.controller,
    required this.onChange,
  });

  final void Function(String) onChange;
  final void Function(String)? onSubmitted;
  final TextEditingController controller;

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  late FocusNode _focusNode;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(KeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (widget.onSubmitted != null) {
        widget.onSubmitted!(widget.controller.text);
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
          color:
              _hovering
                  ? Colors.white.withAlpha(30)
                  : Colors.white.withAlpha(0),
        ),
        child: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: _onKey,
          child: Container(
            child: TextField(
              onChanged: widget.onChange,
              controller: widget.controller,
              maxLines: null,
              cursorHeight: 48,
              cursorWidth: 3,
              cursorRadius: Radius.circular(20),
              textAlign: TextAlign.left,
              decoration: InputDecoration.collapsed(
                hintText: 'Seu Título',
                hintStyle: AppTextStyles.styles[ElementTag.title]!.copyWith(
                  color: Colors.white.withAlpha(20),
                ),
              ),
              style: AppTextStyles.styles[ElementTag.title],
              cursorColor: AppColorsDark.defaultText,
            ),
          ),
        ),
      ),
    );
  }
}
