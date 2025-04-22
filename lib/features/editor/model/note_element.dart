import 'package:brill_app/features/editor/plugins/block_type.dart';

abstract class NoteElement {
  final BlockType type;

  NoteElement({required this.type});

  Map<String, dynamic> toJson();

  @override
  String toString();
}

// class ListNoteElement extends NoteElement {
//   final List<ListItem> items;

//   ListNoteElement({required super.type, required this.items});

//   @override
//   T accept<T>(NoteElementVisitor<T> visitor) {
//     return visitor.visitList(this);
//   }
// }

// abstract class ListItem {
//   final TextEditingController controller;

//   ListItem({required this.controller});
// }

// class BulletedListItem extends ListItem {
//   BulletedListItem({required super.controller});
// }

// class EnumeratedListItem extends ListItem {
//   int index;

//   EnumeratedListItem({required this.index, required super.controller});
// }

// class TodoListItem extends ListItem {
//   bool done;

//   TodoListItem({required this.done, required super.controller});
// }

// class ImageNoteElement extends NoteElement {
//   final String imageUrl;

//   ImageNoteElement({required super.type, required this.imageUrl});

//   @override
//   T accept<T>(NoteElementVisitor<T> visitor) {
//     return visitor.visitImage(this);
//   }
// }
