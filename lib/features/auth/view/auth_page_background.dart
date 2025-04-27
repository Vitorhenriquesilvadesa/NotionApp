import 'dart:ui';

import 'package:brill_app/features/auth/view/title_bar.dart.dart';
import 'package:flutter/material.dart';

class AuthPageBackground extends StatelessWidget {
  const AuthPageBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'assets/images/bg002.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.black.withAlpha(20),
                      Colors.black.withAlpha(230),
                    ],
                  ),
                ),
              ),
            ),
            TitleBar(
              title: "Brill",
              backgroundColor: Colors.black.withAlpha(150),
            ),
            child,
          ],
        ),
      ],
    );
  }
}
