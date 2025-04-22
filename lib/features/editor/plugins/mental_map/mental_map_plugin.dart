import 'package:brill_app/features/editor/plugins/mental_map/model/mental_map_note_element.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/note_element_plugin.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:brill_app/features/editor/plugins/mental_map/widgets/mental_map_composite_node.dart';

class MentalMapPlugin extends NoteElementPlugin<MentalMapNoteElement> {
  @override
  MentalMapNoteElement createElement() {
    return MentalMapNoteElement(nodes: []);
  }

  @override
  TextCompositeNode<MentalMapNoteElement> createWidget(
    MentalMapNoteElement element,
  ) {
    return MentalMapCompositeNode(element: element);
  }

  @override
  MentalMapNoteElement deserialize(Map<String, dynamic> json) {
    // TODO: implement deserialize
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> serialize(MentalMapNoteElement element) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  @override
  // TODO: implement type
  BlockType get type => BlockType.mentalMap;
}
