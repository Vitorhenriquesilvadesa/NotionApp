import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/block_type.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';

abstract class NoteElementPlugin {
  BlockType get type;

  NoteElement createElement();
  TextCompositeNode createWidget(NoteElement element);
  Map<String, dynamic> serialize(NoteElement element);
  NoteElement deserialize(Map<String, dynamic> json);
}
