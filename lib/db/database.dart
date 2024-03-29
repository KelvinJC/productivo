
import 'package:path/path.dart';
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
      onCreate: (Database db, int version) async {
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

        await db.execute(
        '''
         CREATE TABLE user(
           id INTEGER AUTOINCREMENT NOT NULL,
           uid TEXT PRIMARY KEY,
           email TEXT,
           display_name TEXT,
           phone_number TEXT,
           photo_url TEXT,
           is_active INTEGER,
           UNIQUE(uid, email)
           )
        '''
       );
      },
    );
    return database;
  }


  static Future<bool> checkDatabaseCreation() async {
    // initialize the database connection
    Database db = await DB._databaseConnection();

    // query the sqlite_master table to check for the existence of the necessary tables
    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    final tableNames = tables.map((row) => row['name'] as String).toList();

    // check if the necessary tables exist in the database
    if (tableNames.contains('event')
        && tableNames.contains('user')
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


