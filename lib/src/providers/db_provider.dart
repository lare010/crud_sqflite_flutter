import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crud_sqlite/src/models/category_model.dart';
export 'package:crud_sqlite/src/models/category_model.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    final String path = join(directory.path, 'dbData.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE category ("
            "id INTEGER PRIMARY KEY,"
            "categoryname TEXT"
            ")");
      },
    );
  }

  //Crear Categorias
  Future<int> newCategory(CategoryModel newcatg) async {
    final db = await database;
    final res = await db.insert('category', newcatg.toJson());

    return res;
  }

  // Listar Categorias
  Future<List<CategoryModel>> getCategory() async {
    final db = await database;
    final res = await db.query('category');

    List<CategoryModel> list = res.isNotEmpty
        ? res.map((e) => CategoryModel.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<CategoryModel> getCategoryId(int id) async {
    final db = await database;
    final res = await db.query('category', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? CategoryModel.fromJson(res.first) : null;
  }

  // Actualizar Categorias
  Future<int> updateCategory(CategoryModel newcatg) async {
    final db = await database;
    final res = await db.update('category', newcatg.toJson(),
        where: 'id = ?', whereArgs: [newcatg.id]);

    return res;
  }

  //Borrar Categorias
  Future<int> deleteCategoryId(int id) async {
    final db = await database;
    final res = await db.delete('category', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteCategory() async {
    final db = await database;
    final res = await db.delete('category');

    return res;
  }
}
