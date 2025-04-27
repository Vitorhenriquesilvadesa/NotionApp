import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            obscureText: _showPassword,
            decoration: InputDecoration.collapsed(
              hintText: 'Password',
              hintStyle: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Icon(
              _showPassword ? Icons.visibility_off : Icons.visibility,
            ),
            onTap: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
        ),
      ],
    );
  }
}
