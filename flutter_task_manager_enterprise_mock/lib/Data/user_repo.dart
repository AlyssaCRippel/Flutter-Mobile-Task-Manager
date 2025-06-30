import '../repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepo implements UserRepository {
  final List<User> _users = [];

  @override
  Future<User> getUser(String email) async {
    return _users.firstWhere((user) => user.email == email);
  }

  @override
  Future<void> createUser(User user) async {
    _users.add(user);
  }

  @override
  Future<void> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
  }

  @override
  Future<void> deleteUser(String email) async {
    _users.removeWhere((user) => user.email == email);
  }
}