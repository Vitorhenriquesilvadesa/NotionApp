import 'dart:convert';

import 'package:brill_app/backend/model/note.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NoteService {
  List<Note> notes = [];
  final String apiUrl = "http://notion_api/note";

  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Note.fromJSON(e)).toList();
    } else {
      throw Exception("Error to load notes.");
    }
  }

  Future<Note> createNote(String title) async {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return Note.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Error to create note.");
    }
  }

  Future<Note> updateNote(String newTitle, String? newContent) async {
    throw UnimplementedError();
  }

  void removeNote(Note note) {
    notes.remove(note);
  }
}
