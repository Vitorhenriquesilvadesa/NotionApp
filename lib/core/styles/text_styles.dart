import 'package:brill_app/features/editor/model/element_text_style.dart';
import 'package:brill_app/features/editor/utils/code_lexer.dart';
import 'package:flutter/material.dart';

enum ElementTag { h1, h2, h3, h4, h5, h6, normal, title }

class CodeHighlightStyles {
  static const lineHeight = 1.4;
  static const fontSize = 18.0;

  static const keyword = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color(0xFFC678DD),
    height: lineHeight,
  );

  static const identifier = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 123, 189, 255),
    height: lineHeight,
  );

  static const type = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color(0xFFE5C07B),
    height: lineHeight,
  );

  static const number = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color(0xFFD19A66),
    height: lineHeight,
  );

  static const string = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color(0xFF98C379),
    height: lineHeight,
  );

  static const operator = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color(0xFF56B6C2),
    height: lineHeight,
  );

  static const punctuation = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color(0xFFABB2BF),
    height: lineHeight,
  );

  static const eof = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color(0xFFB2B2B2),
    height: lineHeight,
  );

  static const comment = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 143, 143, 143),
    height: lineHeight,
  );

  static const Map<TokenType, TextStyle> tokenStyles = {
    TokenType.keyword: keyword,
    TokenType.identifier: identifier,
    TokenType.number: number,
    TokenType.string: string,
    TokenType.operator: operator,
    TokenType.comment: comment,
    TokenType.punctuation: punctuation,
    TokenType.eof: eof,
  };
}

class ElementTextStyles {
  static const styles = {
    ElementTextStyle.code: AppTextStyles.codeField,
    ElementTextStyle.monospace: AppTextStyles.codeField,
    ElementTextStyle.normal: AppTextStyles.normal,
    ElementTextStyle.title1: AppTextStyles.h1,
    ElementTextStyle.title2: AppTextStyles.h2,
    ElementTextStyle.citation: AppTextStyles.citation,
  };
}

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

  static const codeField = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  static const codeTitle = TextStyle(
    fontFamily: "JetBrains Mono",
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

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

  static const citation = TextStyle(
    fontFamily: "Roboto",
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
  );
}
