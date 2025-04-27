import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  const GradientButton({required this.onPress, super.key});

  final void Function() onPress;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPress();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          setState(() {
            _isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHover = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors:
                  _isHover
                      ? [
                        const Color.fromRGBO(218, 34, 255, 1),
                        const Color.fromRGBO(151, 51, 238, 1),
                        const Color.fromARGB(255, 71, 34, 255),
                        const Color.fromARGB(255, 71, 34, 255),
                      ]
                      : [
                        const Color.fromARGB(255, 42, 18, 163),
                        const Color.fromARGB(255, 37, 14, 154),
                        const Color.fromARGB(255, 85, 22, 141),
                        const Color.fromARGB(255, 134, 13, 159),
                      ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              "Log in",
              style: TextStyle(fontSize: 16, fontFamily: "Montserrat"),
            ),
          ),
        ),
      ),
    );
  }
}
