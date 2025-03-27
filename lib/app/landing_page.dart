import 'package:brill_app/app/goto.dart';
import 'package:brill_app/article/article_view.dart';
import 'package:brill_app/editor/article_editor_page.dart';
import 'package:brill_app/settings/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GotoButton(
                backgroundColor: transparentMask,
                margin: 30,
                sideSize: 200,
                title: "Articles",
                icon: Icons.article,
                destination: ArticlesView(),
              ),
              GotoButton(
                backgroundColor: transparentMask,
                margin: 30,
                sideSize: 200,
                title: "Editor",
                icon: Icons.edit,
                destination: ArticleEditorPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
