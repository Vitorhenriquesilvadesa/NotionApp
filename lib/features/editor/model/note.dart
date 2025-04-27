import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/plugin_registry.dart';

class Note {
  int id;
  String title;
  List<NoteElement> elements;

  Note({required this.id, required this.title, required this.elements});

  Map<String, dynamic> toJson() {
    return {
      "noteId": id,
      "title": title,
      "elements": elements.map((e) => e.toJson()).toList(),
    };
  }

  static BlockType noteElementTypeFromString(String type) {
    return BlockType.values.firstWhere((e) => e.name == type);
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"],
      title: json["title"],
      elements:
          (json["elements"] as List<dynamic>).map((e) {
            final type = noteElementTypeFromString(e["type"]);
            final plugin = NoteElementPluginRegistry().get(type);
            return plugin!.deserialize(e);
          }).toList(),
    );
  }
}
