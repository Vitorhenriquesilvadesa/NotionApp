import 'dart:math';

import 'package:brill_app/features/editor/plugins/shared/block_type.dart';

abstract class NoteElement {
  final BlockType type;
  final int noteId;
  String orderKey;

  NoteElement({
    required this.orderKey,
    required this.noteId,
    required this.type,
  });

  Map<String, dynamic> serialize() {
    return {'type': type.name, 'orderKey': orderKey, 'content': toJson()};
  }

  Map<String, dynamic> toJson();

  @override
  String toString();
}
