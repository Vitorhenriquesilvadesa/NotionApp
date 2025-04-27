import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';

abstract class NoteElementPlugin<T extends NoteElement> {
  BlockType get type;

  T createElement(int noteId, String orderKey);
  TextCompositeNode<T> createWidget(T element);
  Map<String, dynamic> serialize(T element);
  T deserialize(Map<String, dynamic> json);
}
