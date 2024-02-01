import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo/common/errors/error_status.dart';
import '../../db/database.dart';
import '../repo/event_interface.dart';
import '../models/event_model.dart';


class EventRepository implements IEventRepository {
  final DB _db;

  const EventRepository(this._db);

  @override
  Future<List<Event>> getAll() async {
    try {
      Database db = await _db.database;
      final List<Map<String, dynamic>> maps = await db.query('event');

      return List.generate(
        maps.length,
            (i) => Event(
          id: maps[i]['id'],
          title: maps[i]['title'],
          start: maps[i]['start'],
          end: maps[i]['end'],
          category: maps[i]['category'],
          note: maps[i]['note'],
          reminder: maps[i]['reminder'],
          location: maps[i]['location'],
          priority: maps[i]['priority'],
        ),
      );
    } catch (e) {
      print('Error fetching events: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<Event?> getOne(int eventId) async {
    try {
      // Get a reference to the database.
      var db = await _db.database;

      // Perform the query on the 'event' table.
      List<Map<String, dynamic>> maps = await db.query('event', where: 'id = ?', whereArgs: [eventId],);

      // Check if any rows were returned.
      if (maps.isNotEmpty) {
        // Convert the first row to an Event object.
        return Event.fromMap(maps.first);
      }
      // If no rows were found, return null.
      return null;
    } catch (e) {
      print('Error getting event: $e');
      throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> insert(Event event) async {
    try {
      // Get a reference to the database.
      var db = await _db.database;
      final id = await db.insert(
          'event',
          event.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace
      );
      return id;
    } catch (e) {
    print('Error getting event: $e');
    throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> update(Event event) async {
    try{
      Database db = await _db.database;
      int numRowsUpdated = await db!.update(
        'event',
        event.toMap(),
        where: 'id = ?',
        whereArgs: [event.id], // Assuming 'id' is the primary key
      );
      return numRowsUpdated;
    } catch (e) {
    print('Error updating event: $e');
    throw Failure(errorResponse: e.toString());
    }
  }

  @override
  Future<int> delete(int eventId) async {
    try {
      // Get a reference to the database.
      var db = await _db.database;
      // Perform the delete operation on the 'event' table.
      int rowsDeleted = await db.delete(
        'event',
        where: 'id = ?',
        whereArgs: [eventId],
      );
      return rowsDeleted;
    } catch (e) {
    print('Error deleting event: $e');
    throw Failure(errorResponse: e.toString());
    }
  }

  Future<int> getCount() async {
    try{
      int count = 0;
      //final db = await database;
      Database db = await _db.database;
      final result = await db.rawQuery('SELECT COUNT(*) FROM event');
      print!(result);
      count = result.length;
      return count;
    } catch (e) {
    print('Error getting count of events: $e');
    throw Failure(errorResponse: e.toString());
    }
  }
}

