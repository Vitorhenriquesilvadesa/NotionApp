import 'package:brill_app/features/editor/model/code_note_element.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/block_plugin.dart';
import 'package:brill_app/features/editor/plugins/block_type.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/code_composite_node.dart';

class CodePlugin extends NoteElementPlugin {
  @override
  NoteElement createElement() {
    return CodeNoteElement(language: "java", source: "");
  }

  @override
  TextCompositeNode<NoteElement> createWidget(NoteElement element) {
    return CodeCompositeNode(element: element as CodeNoteElement);
  }

  @override
  NoteElement deserialize(Map<String, dynamic> json) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> serialize(NoteElement element) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  BlockType get type => BlockType.code;
}
