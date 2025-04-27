import 'package:brill_app/features/editor/model/note_element.dart';

class ImageNoteElement extends NoteElement {
  final String imageUrl;

  ImageNoteElement({
    required super.type,
    required this.imageUrl,
    required super.orderKey,
    required super.noteId,
  });

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
