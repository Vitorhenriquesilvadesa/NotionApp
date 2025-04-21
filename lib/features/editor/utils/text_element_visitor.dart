import 'package:brill_app/features/editor/model/note_element.dart';

abstract class NoteElementVisitor<T> {
  T accept(NoteElement value);
  T visitText(ParagraphNoteElement element);
  T visitList(ListNoteElement element);
  T visitCode(CodeNoteElement element);
  T visitImage(ImageNoteElement element);
}
