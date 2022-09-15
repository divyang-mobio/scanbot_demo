import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanbot_demo/photo_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _init();

  Future<Database> _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "scan_image.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE SCAN(
    id INTEGER PRIMARY KEY,
    image STRING
  )
  ''');
  }

  Future<int> add(PhotoModel location) async {
    print("call");
    Database db = await instance.database;
    return await db.insert('SCAN', location.toJson());
  }

  Future<List<PhotoModel>> getData() async {
    Database db = await instance.database;
    var images = await db.query('SCAN');
    List<PhotoModel> photoList = images.isNotEmpty
        ? images.map((c) => PhotoModel.fromJson(c)).toList()
        : [];
    return photoList;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('SCAN', where: "id = ?", whereArgs: [id]);
  }
}
