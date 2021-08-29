import 'package:note_app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          creation_date DATE
          )
          ''');
    }, version: 1);
  }

  addNewNote(NoteModel note) async {
    final db = await database;
    if (db != null) {
      db.insert('notes', note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  deleteNote(int id) async {
    final db = await database;
    if (db != null) {
      db.delete('notes', where: "id = ?", whereArgs: [id]);
    }
  }

  Future<dynamic> getNotes() async {
    List<NoteModel> notesList = [];
    final db = await database;
    if (db != null) {
      final res = await db.query("notes");
      if (res.length == 0) {
        return notesList;
      } else {
        final resMap = res.toList();
        for (var i = 0; i < resMap.length; i++) {
          String title = resMap[i]['title'].toString();
          String body = resMap[i]['body'].toString();
          int id = int.parse(resMap[i]['id'].toString());
          DateTime date = DateTime.parse(resMap[i]['creation_date'].toString());
          NoteModel noteModel =
              NoteModel(title: title, body: body, date: date, id: id);
          notesList.add(noteModel);
        }
        return notesList;
      }
    }
  }
}
