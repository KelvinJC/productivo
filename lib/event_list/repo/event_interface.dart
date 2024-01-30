
import '../models/event_model.dart';

abstract class IEventRepository {
  Future<List<Event>> getAll();
  Future<Event?> getOne(int id);
  Future<int> insert(Event event);
  Future<int> update(Event event);
  Future<int> delete(int id);
}