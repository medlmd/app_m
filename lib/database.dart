import 'dart:async';
import 'package:flutter_login/type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class WebSiteDatabase {
  final database = openDatabase(

    join('database4.db'),

    onCreate: (db, version) {

      db.execute(
        "CREATE TABLE publicationn(author TEXT , Title TEXT, Desc BLOB, Image TEXT, nbLike TEXT, Time TEXT)",
      );

    },
    version: 1,
  );





  Future<void> deleteNews() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'publicationn',
    );
  }







  Future<void> insertNew(New webSiteFavorite) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'publicationn',
      webSiteFavorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<New>> getAllNews() async {
    // Get a reference to the database.
    final Database db = await database;


    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM publicationn ORDER BY datetime(Time) DESC");

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return New(
        author: maps[i]['author'],
        title: maps[i]['Title'],
        desc: maps[i]['Desc'],
        img: maps[i]['Image'],
        nbLike: maps[i]['nbLike'],
        time: maps[i]['Time'],
      );
    });
  }



}