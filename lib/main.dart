import 'package:brill_app/core/app/app.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/plugins/code/code_plugin.dart';
import 'package:brill_app/features/editor/plugins/list/list_plugin.dart';
import 'package:brill_app/features/editor/plugins/mental_map/mental_map_plugin.dart';
import 'package:brill_app/features/editor/plugins/paragraph/paragraph_plugin.dart';
import 'package:brill_app/features/editor/plugins/shared/plugin_registry.dart';
import 'package:brill_app/features/editor/service/editor_service.dart';
import 'package:brill_app/features/notes/note_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.setTitle("Brill");

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  NoteElementPluginRegistry().register(ParagraphPlugin());
  NoteElementPluginRegistry().register(CodePlugin());
  NoteElementPluginRegistry().register(MentalMapPlugin());
  NoteElementPluginRegistry().register(ListPlugin());

  Get.put(NoteController());
  Get.put(EditorController());

  runApp(const BrillApp());
}
