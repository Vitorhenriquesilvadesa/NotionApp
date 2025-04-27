import 'package:brill_app/core/network/session_manager.dart';
import 'package:brill_app/core/theme/dark.dart';
import 'package:brill_app/core/theme/light.dart';
import 'package:brill_app/features/auth/view/register_page.dart';
import 'package:brill_app/features/editor/view/editor/editor_note_space.dart';
import 'package:brill_app/features/editor/view/editor/editor_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrillApp extends StatelessWidget {
  const BrillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuilder<Widget>(
        future: getFirstPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar a página'));
          } else {
            return snapshot.data ?? const SizedBox();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }

  Future<Widget> getFirstPage() async {
    final loginStatus = await SessionManager().tryRestoreSession();

    debugPrint(loginStatus.toString());

    if (loginStatus.isSuccess) {
      return NoteEditorPage();
    } else {
      return RegisterPage();
    }
  }
}
