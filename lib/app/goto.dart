import 'package:brill_app/settings/colors.dart';
import 'package:flutter/material.dart';

class GotoButton extends StatelessWidget {
  const GotoButton({
    super.key,
    required this.backgroundColor,
    required this.sideSize,
    required this.margin,
    required this.title,
    required this.icon,
    required this.destination,
  });

  final Color backgroundColor;
  final double sideSize;
  final double margin;
  final String title;
  final IconData icon;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: Column(
        children: [
          Container(
            width: sideSize,
            height: sideSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              icon: Icon(
                icon,
                size: sideSize * 0.75,
                color: landingForegroundColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return destination;
                    },
                  ),
                );
              },
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 30, color: landingForegroundColor),
          ),
        ],
      ),
    );
  }
}
