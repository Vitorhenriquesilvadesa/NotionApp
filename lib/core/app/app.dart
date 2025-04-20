import 'package:brill_app/core/theme/dark.dart';
import 'package:brill_app/core/theme/light.dart';
import 'package:brill_app/features/editor/view/editor_page.dart';
import 'package:flutter/material.dart';

class BrillApp extends StatelessWidget {
  const BrillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteEditorPage(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
