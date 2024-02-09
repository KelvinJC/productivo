import '../models/user.dart';

abstract class IUserRepository {
  Future<List<User>> getAll();
  Future<User?> getOne(String email);
  Future<User?> getActive();
  Future<int> insert(User user);
  Future<int> update(User user);
  Future<int> delete(String uid);
  Future<int> setActive(User user);
  Future<int> deactivate(User user);

}

