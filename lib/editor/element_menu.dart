import 'package:brill_app/settings/colors.dart';
import 'package:flutter/material.dart';

class ElementMenu extends StatelessWidget {
  const ElementMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Icon icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: transparentMask),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
