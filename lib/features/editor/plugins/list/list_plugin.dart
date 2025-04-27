import 'package:brill_app/features/editor/plugins/list/model/list_note_element.dart';
import 'package:brill_app/features/editor/plugins/list/widgets/list_composite_node.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/note_element_plugin.dart';

class ListPlugin extends NoteElementPlugin<ListNoteElement> {
  @override
  ListNoteElement createElement(int noteId, String orderKey) {
    return ListNoteElement(noteId: noteId, orderKey: orderKey, items: []);
  }

  @override
  TextCompositeNode<ListNoteElement> createWidget(ListNoteElement element) {
    return ListCompositeNode(element: element);
  }

  @override
  ListNoteElement deserialize(Map<String, dynamic> json) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> serialize(ListNoteElement element) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  BlockType get type => BlockType.list;
}
