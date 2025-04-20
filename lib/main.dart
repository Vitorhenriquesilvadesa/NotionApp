import 'package:brill_app/core/app/app.dart';
import 'package:brill_app/features/editor/controller/note_editing_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main() {
  Get.put(NoteEditingController());

  runApp(const BrillApp());
}
