import 'package:brill_app/features/editor/model/mental_map_note_element.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/block_plugin.dart';
import 'package:brill_app/features/editor/plugins/block_type.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/mental_map.dart';

class MentalMapPlugin extends NoteElementPlugin {
  @override
  NoteElement createElement() {
    return MentalMapNoteElement(nodes: []);
  }

  @override
  TextCompositeNode<NoteElement> createWidget(NoteElement element) {
    return MentalMapCompositeNode(element: element as MentalMapNoteElement);
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
  // TODO: implement type
  BlockType get type => BlockType.mentalMap;
}
