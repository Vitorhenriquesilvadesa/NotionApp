import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';

class CodeNoteElement extends NoteElement {
  String language;
  String source;

  CodeNoteElement({
    required super.noteId,
    required super.orderKey,
    required this.source,
    required this.language,
  }) : super(type: BlockType.code);

  @override
  Map<String, dynamic> toJson() {
    return {
      'content': {'source': source, 'language': language},
    };
  }

  @override
  String toString() {
    return "Code {$language | $source}";
  }

  factory CodeNoteElement.fromJson(Map<String, dynamic> json) {
    return CodeNoteElement(
      orderKey: json['orderKey'],
      noteId: json['noteId'],
      source: json['source'],
      language: json['language'],
    );
  }
}
