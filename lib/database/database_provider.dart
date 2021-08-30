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
      // docsda baxdim bu insert ozu id qaytarir yeni db son hansi idni verirse onu bize qaytarir,
      // sozsuz insert metodu ozu Future(jsdaki Promise)gedir deyene biz bu idni gozlemeliyik ona gore await eledik.
      // sora bu idni alannan sora note obyektimizin idsine assign edirik.
      // Unutma biz NoteModeli yaradanda idni konstruktordan gondermirik, halbuki evvel sen ele edirdin ve hemise 1
      // verirdin ona gore de birden cox NoteModel yaradanmirdiq(idni Primary Key olaraq tanimlamisiq)

      int id = await db.insert('notes', note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      note.id = id;
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
        res
            .toList()
            .forEach((map) => notesList.add(new NoteModel.fromMap(map)));

        // burda etdiklerini konstruktor edecekdi, sadece map gondermeyin yeter

        // final resMap = res.toList();
        // for (var i = 0; i < resMap.length; i++) {
        //   String title = resMap[i]['title'].toString();
        //   String body = resMap[i]['body'].toString();
        //   int id = int.parse(resMap[i]['id'].toString());
        //   DateTime date = DateTime.parse(resMap[i]['creation_date'].toString());
        //   NoteModel noteModel =
        //       NoteModel(title: title, body: body, date: date, id: id);
        //   notesList.add(noteModel);
        // }
        return notesList;
      }
    }
  }
}
