class Note {
  Note({
    required this.id,
    required this.createdAt,
    required this.title,
    this.content,
    required this.updatedAt,
    required this.userId,
  });

  int id;
  DateTime createdAt;
  String title;
  String? content;
  DateTime updatedAt;
  int userId;

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> json = {};

    json["id"] = id;
    json["createdAt"] = createdAt.toIso8601String();
    json["title"] = title;
    json["content"] = content;
    json["updatedAt"] = updatedAt.toIso8601String();
    json["userId"] = userId;

    return json;
  }

  factory Note.fromJSON(Map<String, dynamic> json) {
    return Note(
      createdAt: DateTime.parse(json["createdAr"]),
      id: json["id"],
      title: json["title"],
      updatedAt: json["updatedAt"],
      userId: json["userId"],
      content: json["content"],
    );
  }
}
