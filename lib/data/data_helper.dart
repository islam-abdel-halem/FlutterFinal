import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:finalproject/models/diet_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'diets.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Diets (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            ingredients TEXT NOT NULL,
            iconPath TEXT NOT NULL,
            level TEXT NOT NULL,
            duration TEXT NOT NULL,
            calorie TEXT NOT NULL,
            boxColor TEXT NOT NULL,
            viewIsSelected INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertDiet(DietModel diet) async {
    final db = await database;
    return await db.insert('Diets', diet.toMap());
  }

  Future<List<DietModel>> getAllDiets() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('Diets');
    return result.map((map) => DietModel.fromMap(map)).toList();
  }

  Future<int> updateDiet(DietModel diet) async {
    final db = await database;
    return await db.update('Diets', diet.toMap(),
        where: 'name = ?', whereArgs: [diet.name]);
  }

  Future<int> deleteDiet(String name) async {
    final db = await database;
    return await db.delete('Diets', where: 'name = ?', whereArgs: [name]);
  }
}
