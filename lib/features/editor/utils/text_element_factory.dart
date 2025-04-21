import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/utils/text_element_visitor.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';

class TextElementFactory extends TextElementVisitor<TextElement> {
  @override
  TextElement visitCode(CodeNoteElement element) {
    // TODO: implement visitCode
    throw UnimplementedError();
  }

  @override
  TextElement visitImage(ImageNoteElement element) {
    // TODO: implement visitImage
    throw UnimplementedError();
  }

  @override
  TextElement visitList(ListNoteElement element) {
    // TODO: implement visitList
    throw UnimplementedError();
  }

  @override
  TextElement visitText(TextNoteElement element) {
    // TODO: implement visitText
    throw UnimplementedError();
  }
}
