import 'package:brill_app/core/app/app.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/plugins/code_plugin.dart';
import 'package:brill_app/features/editor/plugins/mental_map_plugin.dart';
import 'package:brill_app/features/editor/plugins/paragraph_plugin.dart';
import 'package:brill_app/features/editor/plugins/plugin_registry.dart';
import 'package:brill_app/features/editor/service/editor_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main() {
  NoteElementPluginRegistry().register(ParagraphPlugin());
  NoteElementPluginRegistry().register(CodePlugin());
  NoteElementPluginRegistry().register(MentalMapPlugin());

  Get.put(NoteService());
  Get.put(EditorController());

  runApp(const BrillApp());
}
