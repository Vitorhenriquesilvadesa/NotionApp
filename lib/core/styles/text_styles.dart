import 'package:flutter/material.dart';

enum ElementType { h1, h2, h3, h4, h5, h6, normal, title }

class AppTextStyles {
  static const Map<ElementType, TextStyle> styles = {
    ElementType.h1: h1,
    ElementType.h2: h2,
    ElementType.h3: h3,
    ElementType.h4: h4,
    ElementType.h5: h5,
    ElementType.h6: h6,
    ElementType.normal: normal,
    ElementType.title: pageTitle,
  };

  static const pageTitle = TextStyle(
    fontFamily: "Roboto",
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const h1 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 36,
    fontWeight: FontWeight.normal,
  );

  static const h2 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 32,
    fontWeight: FontWeight.normal,
  );

  static const h3 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 28,
    fontWeight: FontWeight.normal,
  );

  static const h4 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 24,
    fontWeight: FontWeight.normal,
  );

  static const h5 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static const h6 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const normal = TextStyle(
    fontFamily: "Roboto",
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
