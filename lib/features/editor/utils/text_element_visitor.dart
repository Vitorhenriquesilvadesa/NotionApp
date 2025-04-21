import 'package:brill_app/features/editor/model/note_element.dart';

abstract class TextElementVisitor<T> {
  T visitText(TextNoteElement element);
  T visitList(ListNoteElement element);
  T visitCode(CodeNoteElement element);
  T visitImage(ImageNoteElement element);
}
