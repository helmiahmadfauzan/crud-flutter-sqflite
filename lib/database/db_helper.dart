import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
        );
      },
    );
  }

  static Future<int> insert(Map<String, dynamic> data) async {
    final db = await initDb();
    return db.insert('notes', data);
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await initDb();
    return db.query('notes', orderBy: 'id DESC');
  }

  static Future<int> update(Map<String, dynamic> data) async {
    final db = await initDb();
    return db.update('notes', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  static Future<int> delete(int id) async {
    final db = await initDb();
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
