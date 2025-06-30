import '../models/user_model.dart';

/// An abstract class that defines the methods for a user repository.
abstract class UserRepository {
  Future<User> getUser(String email);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String email);
}