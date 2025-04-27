import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:flutter/material.dart';

class MentalMapNode {
  final String id;
  Offset position;
  String text;

  MentalMapNode({required this.id, required this.position, this.text = ''});
}

class MentalMapConnection {
  final String fromId;
  final String toId;

  MentalMapConnection({required this.fromId, required this.toId});
}

class MentalMapNoteElement extends NoteElement {
  MentalMapNoteElement({
    required super.noteId,
    required super.orderKey,
    required this.nodes,
  }) : super(type: BlockType.mentalMap);

  List<MentalMapNode> nodes;
  final List<MentalMapConnection> connections = [];

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
