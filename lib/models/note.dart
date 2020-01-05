class Note {
  final int id;
  final String content;

  Note(this.id, this.content);

  factory Note.fromMap(Map<String, dynamic> json) =>
      Note(json['id'], json['content']);
}
