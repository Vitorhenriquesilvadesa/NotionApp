import 'dart:convert';

import 'package:brill_app/article/katex.dart';
import 'package:brill_app/backend/model/note.dart';
import 'package:brill_app/settings/colors.dart';
import 'package:flutter/material.dart';

class SingleArticleView extends StatelessWidget {
  const SingleArticleView({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: editorBottomSheet,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
              [
                SizedBox(height: 30),
                Text(
                  note.title,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 60),
              ] +
              _parseNoteContent(),
        ),
      ),
    );
  }

  List<Widget> _parseNoteContent() {
    List<Widget> elements = [];

    if (note.content != null) {
      Map<String, dynamic> content = json.decode(note.content!);

      debugPrint(content.toString());

      for (String key in content.keys) {
        if (key == "equation") {
          elements.add(SizedBox(height: 10));
          elements.add(KatexEquation(value: content[key]));
        } else if (key == "text") {
          elements.add(SizedBox(height: 10));
          elements.add(
            Text(
              content[key],
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
        }
      }
    }

    return elements;
  }
}
