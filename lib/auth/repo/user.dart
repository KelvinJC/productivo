import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo/common/errors/error_status.dart';
import '../../db/database.dart';
import '../repo/user_interface.dart';
import '../models/user.dart';


class UserRepository implements IUserRepository {
  final DB _db;

  const UserRepository(this._db);

  @override
  Future<List<User>> getAll() async {
    try {
      Database db = await _db.database;
      final List<Map<String, dynamic>> maps = await db.query('user');

      return List.generate(
        maps.length,
            (i) => User(
              uid: maps[i]['uid'],
              email: maps[i]['email'],
              displayName: maps[i]['display_name'],
              phoneNumber: maps[i]['phone_number'],
              photoUrl: maps[i]['photo_url'],
              isActive: maps[i]['is_active'],
        ),
      );
    } catch (e) {
      print('Error fetching users: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<User?> getOne(String userEmail) async {
    try {
      // Get a reference to the database.
      var db = await _db.database;

      // Perform the query on the 'user' table.
      List<Map<String, dynamic>> maps = await db.query('user', where: 'email = ?', whereArgs: [userEmail],);

      // Check if any rows were returned.
      if (maps.isNotEmpty) {
        // Convert the first row to an User object.
        return User.fromMap(maps.first);
      }
      // If no rows were found, return null.
      return null;
    } catch (e) {
      print('Error getting user: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> insert(User user) async {
    try {
      // Get a reference to the database.
      var db = await _db.database;
      final id = await db.insert(
          'user',
          user.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace
      );
      print('User id returned after insertion is: $id');
      return id;
    } catch (e) {
      print('Error inserting user: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> update(User user) async {
    try{
      Database db = await _db.database;
      int numRowsUpdated = await db!.update(
        'user',
        user.toMap(),
        where: 'uid = ?',
        whereArgs: [user.uid], // Assuming 'uid' is the primary key
      );
      return numRowsUpdated;
    } catch (e) {
      print('Error updating user: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> delete(String uid) async {
    try {
      // Get a reference to the database.
      var db = await _db.database;
      // Perform the delete operation on the 'user' table.
      int rowsDeleted = await db.delete(
        'user',
        where: 'uid = ?',
        whereArgs: [uid],
      );
      return rowsDeleted;
    } catch (e) {
      print('Error deleting user: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  Future<int> getCount() async {
    try{
      int count = 0;
      //final db = await database;
      Database db = await _db.database;
      final result = await db.rawQuery('SELECT COUNT(*) FROM user');
      print!(result);
      count = result.length;
      return count;
    } catch (e) {
      print('Error getting count of users: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> setActive(User user) async {
    Map<String, Object?> isActiveTrue = {'is_active': 1};
    try{
      Database db = await _db.database;
      int numRowsUpdated = await db!.update(
        'user',
        isActiveTrue,
        where: 'uid = ?',
        whereArgs: [user.uid], // Assuming 'uid' is the primary key
      );
      return numRowsUpdated;
    } catch (e) {
      print('Error updating isActive attribute of user: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> deactivate(User user) async {
    Map<String, Object?> isActiveFalse = {'is_active': 0};
    try{
      Database db = await _db.database;
      int numRowsUpdated = await db!.update(
        'user',
        isActiveFalse,
        where: 'uid = ?',
        whereArgs: [user.uid], // Assuming 'uid' is the primary key
      );
      return numRowsUpdated;
    } catch (e) {
      print('Error updating isActive attribute of user: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<User?> getActive() async {
    try {
      // Get a reference to the database.
      var db = await _db.database;

      // Perform the query on the 'user' table.
      List<Map<String, dynamic>> maps = await db.query('user', where: 'is_active = ?', whereArgs: [1],);

      // Check if any rows were returned.
      if (maps.isNotEmpty) {
        // Convert the first row to an User object.
        return User.fromMap(maps.first);
      }
      // If no rows were found, return null.
      return null;
    } catch (e) {
      print('Error getting active user: $e');
      throw Failure(errorResponse: e.toString());
    }
  }
}

