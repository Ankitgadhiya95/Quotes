import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/Model/quote_model.dart';

class DataBaseRepo {
  /// Create Database and OPNE Database

  Future<Database> db() async {
    return openDatabase('dbtech.db', version: 3,
        onCreate: (database, int version) async {
      await _createDB(database, version);
      // await _createDB1(database, version);
    });
  }

  /// Create Database Table

  List<String> list = [
    'Alone',
    'Angry',
    'Anniversary',
    'Attitude',
    'Awesome',
    'Beard',
    'Beautiful',
    'Bike',
    'Birthday',
    'Busy'
  ];

  List<Color> colorList = [
    Colors.lightBlue,
    Colors.deepPurpleAccent,
    Colors.pinkAccent,
    Colors.yellow,
    Colors.lightBlueAccent,
    Colors.green,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueGrey,
    Colors.pink
  ];

  Future _createDB(Database db, int version) async {
    for (int i = 0; i < 10; i++) {
      await db.execute('''
    create table ${list[i]}(
    id integer primary key autoincrement,
    quote text not null,
    img text not null,
    isFav integer not null)''');
    }
  }

  static Future likeDB(Database db) async {
    await db.execute('''
    create table LikeQuoteTable(
    id integer primary key autoincrement,
    quote text not null,
    img text not null,
    isFav integer not null)''');
  }

  /// Insert Record

  static Future createItem(
      String quote, int isFav, String table, Database db, String img) async {
    // final db = await DataBaseRepo.db();
    final data = {'quote': quote, 'img': img, 'isFav': isFav};
    final id = await db.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    //print(id);
    return id;
  }

  static Future createLikeItem(String quote, int isFav, String img) async {
    final db = await DataBaseRepo().db();

    final data = {'quote': quote, 'img': img, 'isFav': isFav};
    final id = await db.insert("LikeQuoteTable", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    return id;
  }

  /// Get data from database

  static Future getItems(String table) async {
    List<QuoteModel> todoList = [];
    final db = await DataBaseRepo().db();
    var data = await db.query(table, orderBy: 'id');
    for (var e in data) {
      todoList.add(QuoteModel.fromJson(e));
    }
    return todoList;
  }

  static Future getLikeItems() async {
    List<QuoteModel> todoList = [];
    final db = await DataBaseRepo().db();
    var data = await db.query("LikeQuoteTable", orderBy: 'id');
    for (var e in data) {
      todoList.add(QuoteModel.fromJson(e));
    }
    return todoList;
  }

// ///Update Item
//
// static Future updateItem(int id, String title, String description) async {
//   final db = await DataBaseRepo.db();
//   final data = {'title': title, 'description': description};
//   final result =
//       await db.update('todoTable', data, where: 'id=?', whereArgs: [id]);
//   return result;
// }
//
  ///Delete Item

  static Future deleteItem(int id) async {
    final db = await DataBaseRepo().db();
    try {
      await db.delete('LikeQuoteTable', where: "id=?", whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }
//
// ///Get Items by id
//
// static Future getItemsbyId(int id) async {
//   final db = await DataBaseRepo.db();
//   List<ToDoModel> todoList = [];
//   var data = await db.query('todoTable', whereArgs: [id], where: "id=?");
//   for (var e in data) {
//     todoList.add(ToDoModel.fromJson(e));
//   }
//   return todoList;
// }
}
