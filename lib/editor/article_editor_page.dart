import 'package:brill_app/editor/article_editor.dart';
import 'package:brill_app/settings/colors.dart';
import 'package:flutter/material.dart';

class ArticleEditorPage extends StatelessWidget {
  const ArticleEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: transparentMask),
      backgroundColor: backgroundColor,
      body: ArticleEditor(),
    );
  }
}
