
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/material.dart';


class DB {
  DB._();
  // ._()  == private constructor
  // Private constructors are often used when you want to restrict
  // the instantiation of a class to within the same file or library
  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _databaseConnection();
      return _database!;
    } else {
      return _database!;
    }
  }

  static Future<Database> _databaseConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = await getDatabasesPath();
    Database database = await openDatabase(
      join(path, 'database.db'),
      version: 1,
      onCreate: (sql.Database db, int version) async {
        print!('creating tables .............');
        await db.execute(
        '''
           CREATE TABLE event(
           id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
           title TEXT,
           start TEXT,
           end TEXT,
           category TEXT,
           note TEXT,
           reminder TEXT,
           location TEXT,
           priority TEXT,
           UNIQUE(title, start, end)
           )
        '''
        );

      // await db.execute(
      // '''
      //  CREATE TABLE user(
      //    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      //    user_id TEXT,
      //    username TEXT,
      //    password TEXT,
      //    UNIQUE(user_id, username)
      //      )
      // '''
      //  );
      },
    );
    return database;
  }


  static Future<bool> _checkDatabaseCreation() async {
    // Initialize the database connection
    var db = await DB._databaseConnection();

    // Query the sqlite_master table to check for the existence of the necessary tables
    final tables =
    await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    final tableNames = tables.map((row) => row['name'] as String).toList();

    // Check if the necessary tables exist in the database
    if (tableNames.contains('event')
        // && tableNames.contains('user')
        // && tableNames.contains('todos')
      ) {
      print!("Database has been created and tables are present.");
      return true;
    } else {
      print!("Database has not been created or tables are missing.");
      return false;
    }
  }
}


