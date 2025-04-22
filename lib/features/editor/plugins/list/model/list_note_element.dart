import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/list/model/list_type.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';

class ListNoteElement extends NoteElement {
  final List<ListItem> items;

  ListNoteElement({required this.items}) : super(type: BlockType.list);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

abstract class ListItem {
  String label;
  final ListType type;

  ListItem({required this.type, required this.label});
}

class BulletedListItem extends ListItem {
  BulletedListItem({required super.label}) : super(type: ListType.dots);
}

class EnumeratedListItem extends ListItem {
  int index;

  EnumeratedListItem({required this.index, required super.label})
    : super(type: ListType.numbers);
}

class TodoListItem extends ListItem {
  bool done;

  TodoListItem({required this.done, required super.label})
    : super(type: ListType.tasks);
}
