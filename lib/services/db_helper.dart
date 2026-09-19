import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/vendor_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'wedding_planner.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE vendors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            category TEXT,
            price REAL,
            contact TEXT
          )
        ''');

        // Akun default
        await db.insert('users', {'username': 'admin', 'password': '123'});
      },
    );
  }

  // Auth Operations
  static Future<int> registerUser(String username, String password) async {
    final db = await database;
    try {
      return await db.insert('users', {'username': username, 'password': password});
    } catch (e) {
      return -1;
    }
  }

  static Future<bool> loginUser(String username, String password) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return res.isNotEmpty;
  }

  // Vendor CRUD Operations
  static Future<int> insertVendor(Vendor vendor) async {
    final db = await database;
    return await db.insert('vendors', vendor.toMap());
  }

  static Future<List<Vendor>> getVendors() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('vendors');
    return List.generate(maps.length, (i) => Vendor.fromMap(maps[i]));
  }

  static Future<int> updateVendor(Vendor vendor) async {
    final db = await database;
    return await db.update('vendors', vendor.toMap(), where: 'id = ?', whereArgs: [vendor.id]);
  }

  static Future<int> deleteVendor(int id) async {
    final db = await database;
    return await db.delete('vendors', where: 'id = ?', whereArgs: [id]);
  }
}