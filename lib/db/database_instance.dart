import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sqflite/db/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance{
  final String _databaseName = 'product.db';
  final int _databaseVersion = 1;

  // Product Table
  final String tableProduct = 'product';
  final String id = 'id';
  final String name = 'name';
  final String category = 'category';
  final String createdAt = 'created_at';
  final String price = 'price';

  Database? _database;

  Future<Database> checkDatabase() async {
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Create table, kalau mau create table lagi, copy saja db.execute
    await db.execute(
      'CREATE TABLE $tableProduct ($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $category TEXT, $createdAt TEXT, $price INTEGER)');
  }

  Future<List<ProductModel>> selectAllProduct() async {
    final data = await _database!.query(tableProduct);
    List<ProductModel> result = data.map((e) => ProductModel.fromJson(e)).toList();
    print(result);
    print(result[0]);
    return result;
  }

  Future<int> insertProduct(Map<String, dynamic> row) async {
    final query = await _database!.insert(tableProduct, row);
    return query;
  }
}