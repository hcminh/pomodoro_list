import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/note.dart';

class DatabaseNote {
  DatabaseNote._();

  static final DatabaseNote db = DatabaseNote._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await init();
    return _database;
  }

  init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Note ('
          'id INTEGER PRIMARY KEY,'
          'content TEXT'
          ')');
    });
  }

  insert(Note note) async {
    var db = await database;

    var table = await db.rawQuery('SELECT MAX(id)+1 as id FROM Note');
    var id = table.first['id'];

    var raw = await db.rawInsert(
        'INSERT Into Note (id, content) VALUES (?,?)',
        [id, note.content]);

    print('Saved: $raw');
    return raw;
  }

  update(Note note) async {
    var db = await database;

    var raw = await db.rawUpdate(
        'UPDATE Note SET content = ? WHERE id = ?',
        [note.content, note.id]);

    print('Updated');
    return raw;
  }

  remove(Note note) async {
    var db = await database;

    var raw = await db.rawUpdate('DELETE FROM Note WHERE id = ?', [note.id]);

    print('Removed');
    return raw;
  }

  Future<List<Note>> getAll() async {
    var db = await database;
    var query = await db.query('Note');

    List<Note> notes =
        query.isNotEmpty ? query.map((t) => Note.fromMap(t)).toList() : [];

    return notes;
  }

  Future<List<Note>> getMany(int limit) async {
    var db = await database;
    var query = await db.query('Note', limit: limit);

    List<Note> notes =
        query.isNotEmpty ? query.map((t) => Note.fromMap(t)).toList() : [];

    return notes;
  }
}
