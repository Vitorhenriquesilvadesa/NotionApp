import 'dart:convert';

import 'package:brill_app/article/single_article_view.dart';
import 'package:brill_app/backend/controller/note_controller.dart';
import 'package:brill_app/backend/model/note.dart';
import 'package:brill_app/settings/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticlesView extends StatefulWidget {
  ArticlesView({super.key});

  @override
  State<ArticlesView> createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> {
  late final NoteController noteController;

  @override
  void initState() {
    super.initState();

    noteController = Get.find();
    noteController.notes =
        <Note>[
          Note(
            id: 0,
            createdAt: DateTime.now(),
            title: "Nota de Teste",
            updatedAt: DateTime.now(),
            content:
                r'{"text": "equação de Einstein", "equation": "\\int_{a}^{b} x^2 \\,dx = \\frac{b^3}{3} - \\frac{a^3}{3}"}',
            userId: 2,
          ),
        ].obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: editorBottomSheet,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: noteController.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              height: 80,
              child: Text(noteController.notes[index].title),
            ),
            onTap: () {
              Get.to(
                () => SingleArticleView(note: noteController.notes[index]),
              );
            },
          );
        },
      ),
    );
  }
}
