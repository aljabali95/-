
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'carwash.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE cars(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            plate TEXT,
            price TEXT,
            payment TEXT,
            image TEXT,
            date TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT,
            role TEXT
          )
        ''');

        await db.insert('users', {
          'username': 'admin',
          'password': '1234',
          'role': 'admin'
        });
      },
    );
  }

  Future insertCar(Map data) async {
    final dbClient = await db;
    return dbClient.insert('cars', data);
  }

  Future<List<Map>> getCars() async {
    final dbClient = await db;
    return dbClient.query('cars', orderBy: 'id DESC');
  }

  Future login(String u, String p) async {
    final dbClient = await db;
    var res = await dbClient.query('users',
      where: 'username=? AND password=?',
      whereArgs: [u, p]);

    if (res.isNotEmpty) return res.first;
    return null;
  }
}
