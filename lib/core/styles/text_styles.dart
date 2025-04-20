import 'package:flutter/material.dart';

enum ElementTag { h1, h2, h3, h4, h5, h6, normal, title }

class AppTextStyles {
  static const Map<ElementTag, TextStyle> styles = {
    ElementTag.h1: h1,
    ElementTag.h2: h2,
    ElementTag.h3: h3,
    ElementTag.h4: h4,
    ElementTag.h5: h5,
    ElementTag.h6: h6,
    ElementTag.normal: normal,
    ElementTag.title: pageTitle,
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
