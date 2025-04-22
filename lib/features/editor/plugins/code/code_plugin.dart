import 'package:brill_app/features/editor/plugins/code/model/code_note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/note_element_plugin.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:brill_app/features/editor/plugins/code/widgets/code_composite_node.dart';

class CodePlugin extends NoteElementPlugin<CodeNoteElement> {
  @override
  CodeNoteElement createElement() {
    return CodeNoteElement(language: "java", source: "");
  }

  @override
  TextCompositeNode<CodeNoteElement> createWidget(CodeNoteElement element) {
    return CodeCompositeNode(element: element);
  }

  @override
  CodeNoteElement deserialize(Map<String, dynamic> json) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> serialize(CodeNoteElement element) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  BlockType get type => BlockType.code;
}
