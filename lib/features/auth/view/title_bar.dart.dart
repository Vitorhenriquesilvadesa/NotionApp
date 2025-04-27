import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final List<Widget> actions;

  const TitleBar({
    super.key,
    this.actions = const [],
    required this.title,
    this.backgroundColor = const Color(0xFF202020),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) => windowManager.startDragging(),
      child: Container(
        height: 40,
        color: backgroundColor,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset("assets/images/app_logo.png"),
                  Text(
                    "",
                    style:
                        textStyle ??
                        const TextStyle(
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          color: Colors.white,
                        ),
                  ),
                  ...actions,
                ],
              ),
            ),
            _WindowControlButton(
              icon: Icons.remove,

              hoverColor: Colors.purple.withAlpha(100),
              onPressed: () => windowManager.minimize(),
            ),
            _WindowControlButton(
              icon: Icons.crop_square,
              hoverColor: Colors.purple.withAlpha(100),
              onPressed: () async {
                bool isMaximized = await windowManager.isMaximized();
                isMaximized
                    ? windowManager.unmaximize()
                    : windowManager.maximize();
              },
            ),
            _WindowControlButton(
              icon: Icons.close,
              onPressed: () => windowManager.close(),
              hoverColor: Colors.purple.withAlpha(100),
            ),
          ],
        ),
      ),
    );
  }
}

class _WindowControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color hoverColor;

  const _WindowControlButton({
    required this.icon,
    required this.onPressed,
    this.hoverColor = const Color(0xFF404040),
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
