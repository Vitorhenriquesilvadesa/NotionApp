import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';

class CodeNoteElement extends NoteElement {
  String language;
  String source;

  CodeNoteElement({required this.source, required this.language})
    : super(type: BlockType.code);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  String toString() {
    return "Code {$language | $source}";
  }
}
