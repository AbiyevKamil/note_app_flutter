class NoteModel {
  final id;
  late String title;
  late String body;
  late DateTime date;

  NoteModel(
      {this.id, required this.title, required this.body, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'creation_date': date.toString()
    };
  }
}
