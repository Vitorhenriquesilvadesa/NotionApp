import 'package:brill_app/features/editor/plugins/shared/block_type.dart';

abstract class NoteElement {
  final BlockType type;

  NoteElement({required this.type});

  Map<String, dynamic> toJson();

  @override
  String toString();
}
