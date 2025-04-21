import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/utils/text_composite_node_builder.dart';
import 'package:brill_app/features/editor/utils/text_element_visitor.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';

class TextCompositeNodeFactory extends NoteElementVisitor<TextCompositeNode> {
  TextCompositeNodeBuilder builder = TextCompositeNodeBuilder();

  @override
  TextCompositeNode accept(NoteElement value) {
    return value.accept(this);
  }

  @override
  TextCompositeNode visitCode(CodeNoteElement element) {
    return builder
        .buildWith<CodeNodeBuilder>()
        .withConfiguration(element)
        .build();
  }

  @override
  TextCompositeNode visitImage(ImageNoteElement element) {
    // TODO: implement visitImage
    throw UnimplementedError();
  }

  @override
  TextCompositeNode visitList(ListNoteElement element) {
    // TODO: implement visitList
    throw UnimplementedError();
  }

  @override
  TextCompositeNode visitText(ParagraphNoteElement element) {
    return builder
        .buildWith<ParagraphNodeBuilder>()
        .withConfiguration(element)
        .build();
  }
}
