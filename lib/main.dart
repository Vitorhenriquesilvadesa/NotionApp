import 'package:brill_app/app/brill.dart';
import 'package:brill_app/backend/controller/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(NoteController());

  runApp(BrillApp());
}
