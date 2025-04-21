import 'package:brill_app/core/app/app.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/controller/node_creation_controller.dart';
import 'package:brill_app/features/editor/service/editor_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main() {
  Get.put(EditorService());
  Get.put(NodeCreationController());
  Get.put(EditorController());

  runApp(const BrillApp());
}
