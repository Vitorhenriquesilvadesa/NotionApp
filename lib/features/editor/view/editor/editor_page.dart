import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/auth/view/title_bar.dart.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/view/editor/activity_bar.dart';
import 'package:brill_app/features/editor/view/editor/editor_note_space.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

enum EditorFileAction { create, save, export }

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final EditorController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleBar(
            title: "Brill",
            backgroundColor: Colors.black.withAlpha(150),
            actions: [
              Expanded(
                child: Row(
                  children: [
                    OptionSelector<EditorFileAction>(
                      options: [
                        Option(label: "New", value: EditorFileAction.create),
                        Option(label: "Save", value: EditorFileAction.save),
                        Option(label: "Export", value: EditorFileAction.export),
                      ],
                      defaultValue: EditorFileAction.save,
                      icon: Text(
                        "File",
                        style: TextStyle(fontFamily: "Montserrat"),
                      ),
                      onSelect: onFileAction,
                    ),
                    Spacer(),
                    Obx(() {
                      return Text(controller.pageTitle);
                    }),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActivityBar(),
                Obx(() {
                  return controller.activeNote.value == null
                      ? Expanded(
                        child: Center(
                          child: Text(
                            "Abra ou crie um novo documento",
                            style: AppTextStyles.h1.copyWith(
                              color: Colors.white.withAlpha(50),
                            ),
                          ),
                        ),
                      )
                      : EditorNoteSpace();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onFileAction(EditorFileAction action) {
    switch (action) {
      case EditorFileAction.create:
        controller.createAndOpen();

      case EditorFileAction.save:
        // TODO: Handle this case.
        throw UnimplementedError();
      case EditorFileAction.export:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
